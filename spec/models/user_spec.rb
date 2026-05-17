require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーション" do
    subject(:user) { User.new(email: "test@example.com", password: "password123") }

    it "有効なデータであれば有効であること" do
      expect(user).to be_valid
    end

    describe "email" do
      it "emailがなければ無効であること" do
        user.email = nil
        expect(user).not_to be_valid
      end

      it "不正なフォーマットのemailは無効であること" do
        user.email = "invalid-email"
        expect(user).not_to be_valid
      end

      it "重複したemailは無効であること" do
        User.create!(email: "test@example.com", password: "password123")
        expect(user).not_to be_valid
      end

      it "大文字小文字を無視して重複したemailは無効であること" do
        User.create!(email: "TEST@EXAMPLE.COM", password: "password123")
        expect(user).not_to be_valid
      end
    end

    describe "password" do
      it "passwordがなければ無効であること" do
        user.password = nil
        expect(user).not_to be_valid
      end
    end
  end
end
