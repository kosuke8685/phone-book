class MembersController < ApplicationController

    #indexメソッドを定義
    def index
        @members = Member.order :yomi
    end

    #newアクションを定義
    def new
        @member = Member.new
    end

    #createアクションを定義
    #@memberに、
    #@memberをsave
    def create
        @member = Member.new(member_params)
        if @member.save
            redirect_to members_path, notice: "#{@member.name}を登録しました。"
            
        else
            render action: :new
        end
    end

    #editアクションを定義
    def edit
        @member = find_member_by_id
    end

    #updateアクションを定義
    def update
        @member = find_member_by_id
        if @member.update(member_params)
            redirect_to member_path, notice: "#{@member.name}を更新しました。"
        else
            render action: :edit
        end
    end

    #destroyメソッドを定義
    def destroy
        @member = find_member_by_id
        @member.destroy
        redirect_to members_path, notice: "#{@member.name}を削除しました。"
    end

    #重複箇所をprivateメソッドを定義して使いまわせるようにする
    private

    #送られてくるパラメータを取得する
    def member_params
        params.require(:member).permit(:name, :yomi, :phone)
    end

    #データベースのテーブルからレコードを取り出す
    def find_member_by_id
        Member.find(params[:id])
    end
end
