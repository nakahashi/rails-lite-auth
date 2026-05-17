require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "GET /signup" do
    it "200を返すこと" do
      get signup_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /signup" do
    let(:valid_params) do
      { user: { email: "new@example.com", password: "password123", password_confirmation: "password123" } }
    end

    context "有効なパラメータの場合" do
      it "homeにリダイレクトすること" do
        post signup_path, params: valid_params
        expect(response).to redirect_to(home_path)
      end

      it "ユーザーが作成されること" do
        expect { post signup_path, params: valid_params }.to change(User, :count).by(1)
      end

      it "セッションにuser_idが保存されること" do
        post signup_path, params: valid_params
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context "メールアドレスが空の場合" do
      it "422を返すこと" do
        post signup_path, params: { user: { email: "", password: "password123", password_confirmation: "password123" } }
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "ユーザーが作成されないこと" do
        expect {
          post signup_path, params: { user: { email: "", password: "password123", password_confirmation: "password123" } }
        }.not_to change(User, :count)
      end
    end

    context "パスワード確認が一致しない場合" do
      it "422を返すこと" do
        post signup_path, params: { user: { email: "new@example.com", password: "password123", password_confirmation: "different" } }
        expect(response).to have_http_status(:unprocessable_content)
      end
    end

    context "メールアドレスが重複している場合" do
      before { User.create!(email: "new@example.com", password: "password123") }

      it "422を返すこと" do
        post signup_path, params: valid_params
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
