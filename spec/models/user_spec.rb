require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it 'does have association with opinion model' do
      association = User.reflect_on_association(:opinions)
      expect(association.macro).to eq(:has_many)
    end

    it 'does have association with likes model' do
      association = User.reflect_on_association(:likes)
      expect(association.macro).to eq(:has_many)
    end

    it { should have_many(:followings).through(:active_followings) }
    it { should have_many(:followers).through(:pasive_followings) }
  end

  context 'Validations' do
    it 'must have username' do
      new_user = User.new(email: 'ert@hg.com', fullname: 'Esteban Pinczing', password: '123123')
      expect(new_user.save).to eq(false)
    end

    it 'must have email' do
      new_user = User.new(username: 'Esteban', fullname: 'Esteban Pinczing', password: '123123')
      expect(new_user.save).to eq(false)
    end

    it 'must have password' do
      new_user = User.new(username: 'Esteban', fullname: 'Esteban Pinczing', email: 'ert@hg.com')
      expect(new_user.save).to eq(false)
    end

    it 'should save having username, fullname, email and password' do
      new_user = User.new(username: 'Esteban', fullname: 'Esteban Pinczing', email: 'ert@hg.com', password: '123123')
      expect(new_user.save).to eq(true)
    end

    it 'fullname length has to be minor than 25 char' do
      new_user = User.new(username: 'esteban1', fullname: 'Thisisaveryveryverylongname really long',
                          email: 'ert@hg.com', password: '123123')
      expect(new_user.save).to eq(false)
    end

    it 'username length has to be minor than 15 char' do
      new_user = User.new(username: 'Thisisaveryveryverylongname', fullname: 'Esteban Pinczing',
                          email: 'ert@hg.com', password: '123123')
      expect(new_user.save).to eq(false)
    end
  end

  context 'Methods' do
    before(:each) do
      @user1 = User.create(username: 'User1', fullname: 'Richard Grikson', email: 'u1@g.com', password: '123123')
      @user2 = User.create(username: 'User2', fullname: 'Richard Merrick', email: 'u2@g.com', password: '123123')
      @user3 = User.create(username: 'User3', fullname: 'Richard Oliver', email: 'u3@g.com', password: '123123')
    end

    it 'user should start with 0 followings' do
      expect(@user1.followings.count).to eql(0)
    end

    it 'should return a following' do
      @user1.follow(@user2)
      expect(@user1.followings.count).to eq(1)
    end

    it 'should return a follower' do
      @user1.follow(@user2)
      expect(@user2.followers.count).to eq(1)
    end

    it 'should return true when user1 follows user2' do
      @user1.follow(@user2)
      expect(@user1.following?(@user2)) == true
    end

    it 'should be two the count of users that user1 is not following' do
      expect(@user1.not_following.count).to eq(2)
    end
  end
end
