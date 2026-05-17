require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { User.create!(email: "test@example.com", password: "password123") }

  describe "GET /login" do
    it "200を返すこと" do
      get login_path
      expect(response).to have_http_status(:ok)
    end

    context "ログイン済みの場合" do
      before { post login_path, params: { email: user.email, password: "password123" } }

      it "homeにリダイレクトすること" do
        get login_path
        expect(response).to redirect_to(home_path)
      end
    end
  end

  describe "POST /login" do
    context "正しい認証情報の場合" do
      it "homeにリダイレクトすること" do
        post login_path, params: { email: user.email, password: "password123" }
        expect(response).to redirect_to(home_path)
      end

      it "セッションにuser_idが保存されること" do
        post login_path, params: { email: user.email, password: "password123" }
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "メールアドレスが間違っている場合" do
      it "422を返すこと" do
        post login_path, params: { email: "wrong@example.com", password: "password123" }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "セッションにuser_idが保存されないこと" do
        post login_path, params: { email: "wrong@example.com", password: "password123" }
        expect(session[:user_id]).to be_nil
      end
    end

    context "パスワードが間違っている場合" do
      it "422を返すこと" do
        post login_path, params: { email: user.email, password: "wrongpassword" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /logout" do
    before { post login_path, params: { email: user.email, password: "password123" } }

    it "loginにリダイレクトすること" do
      delete logout_path
      expect(response).to redirect_to(login_path)
    end

    it "セッションからuser_idが削除されること" do
      delete logout_path
      expect(session[:user_id]).to be_nil
    end
  end
end
