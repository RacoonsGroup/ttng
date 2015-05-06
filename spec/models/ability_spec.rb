require 'pry'
require 'rails_helper'
require "cancan/matchers"

describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when it's chief" do
      let(:user){ FactoryGirl.create(:user, :chief) }

      describe "user model" do
        it{ should be_able_to(:read, User) }
        it{ should be_able_to(:manage, User) }
        it{ should be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should be_able_to(:read, Project) }
        it{ should be_able_to(:manage, Project) }
        it{ should be_able_to(:create, Project) }
      end

      describe "comment model" do
        it{ should be_able_to(:read, Comment ) }
        it{ should be_able_to(:manage, Comment) }
        it{ should be_able_to(:create, Comment) }
      end

      describe "related_task model" do
        it{ should be_able_to(:read, RelatedTask ) }
        it{ should be_able_to(:manage, RelatedTask) }
        it{ should_not be_able_to(:create, RelatedTask) }
      end

      describe "time_entry model" do
        it{ should_not be_able_to(:create, TimeEntry) }
        it{ should be_able_to(:read, TimeEntry ) }
        it{ should be_able_to(:manage, TimeEntry) }
      end

      describe "customer model" do
        it{ should be_able_to(:create, Customer) }
        it{ should be_able_to(:read, Customer ) }
        it{ should be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, Contact) }
        it{ should be_able_to(:create, Contact) }
        it{ should be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should be_able_to(:read, Day) }
        it{ should be_able_to(:manage, Day) }
        it{ should be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should be_able_to(:create, Article) }
        it{ should be_able_to(:manage, Article) }
      end
    end



    context "when it's developer" do
      let(:user){ FactoryGirl.create(:user, :developer) }

      describe "user model" do
        it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should be_able_to(:read, user.projects.first) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, user.projects.first) }
      end

      describe "comment model" do
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :developer, project: user.projects.first)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :developer, project: user.projects.first)) }
        it{ should be_able_to(:read, FactoryGirl.create(:comment, :general, project: user.projects.first)) }

        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general, project: user.projects.first)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial, project: user.projects.first)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:comment, :general, project: user.projects.first)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:comment, :commercial, project: user.projects.first)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :general)) }
      end

      describe "related_task model" do
        it{ should be_able_to(:create, RelatedTask) }
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, user: user)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task, project: user.projects.first)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task, project: user.projects.first)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "time_entry model" do
        it{ should be_able_to(:create, TimeEntry) }
        it{ should be_able_to(:manage, FactoryGirl.create(:time_entry, related_task: FactoryGirl.create(:related_task, user: user))) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:time_entry)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:time_entry)) }
      end

      describe "customer model" do
        it{ should_not be_able_to(:read, Customer) }
        it{ should_not be_able_to(:create, Customer) }
        it{ should_not be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should_not be_able_to(:read, Contact) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should be_able_to(:create, Article) }
        it{ should be_able_to(:manage, FactoryGirl.create(:article, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:article)) }
      end
    end



    context "when it's manager" do
      let(:user){ FactoryGirl.create(:user, :manager) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "user model" do
        it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end
      
      describe "project model" do
        it{ should be_able_to(:manage, project) }
        it{ should be_able_to(:create, Project) }
        it{ should_not be_able_to(:read, Project.new) }
        it{ should_not be_able_to(:manage, Project.new) }
      end

      describe "comment model" do
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :general, project: project)) }
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :general, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :general)) }
      end

      describe "related_task model" do
        it{ should be_able_to(:read, FactoryGirl.create(:related_task, project: project)) }
        it{ should be_able_to(:create, RelatedTask) }
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "time_entry model" do
        it{ should be_able_to(:create, TimeEntry) }
        it{ should be_able_to(:manage, FactoryGirl.create(:time_entry, related_task: FactoryGirl.create(:related_task, user: user))) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:time_entry)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:time_entry)) }
      end

      describe "customer model" do
        it{ should be_able_to(:read, Customer) }
        it{ should_not be_able_to(:create, Customer) }
        it{ should_not be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, Contact) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should be_able_to(:create, Article) }
        it{ should be_able_to(:manage, FactoryGirl.create(:article, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:article)) }
      end
    end



    context "when it's hr" do
      let(:user){ FactoryGirl.create(:user, :hr) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "user model" do
        it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should_not be_able_to(:read, Project) }
        it{ should_not be_able_to(:manage, Project) }
        it{ should_not be_able_to(:create, Project) }
      end

      describe "comment model" do
        it{ should_not be_able_to(:read, Comment ) }
        it{ should_not be_able_to(:manage, Comment) }
        it{ should_not be_able_to(:create, Comment) }
      end

      describe "related_task model" do
        it{ should_not be_able_to(:read, RelatedTask ) }
        it{ should_not be_able_to(:manage, RelatedTask) }
        it{ should_not be_able_to(:create, RelatedTask) }
      end

      describe "time_entry model" do
        it{ should_not be_able_to(:create, TimeEntry) }
        it{ should_not be_able_to(:read, TimeEntry ) }
        it{ should_not be_able_to(:manage, TimeEntry) }
      end

      describe "customer model" do
        it{ should be_able_to(:create, Customer) }
        it{ should be_able_to(:read, Customer ) }
        it{ should be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, Contact) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should be_able_to(:create, Article) }
        it{ should be_able_to(:manage, FactoryGirl.create(:article, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:article)) }
      end
    end



    context "when it's buh" do
      let(:user){ FactoryGirl.create(:user, :buh) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "user model" do
        it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should_not be_able_to(:read, Project) }
        it{ should_not be_able_to(:manage, Project) }
        it{ should_not be_able_to(:create, Project) }
      end

      describe "comment model" do
        it{ should_not be_able_to(:read, Comment ) }
        it{ should_not be_able_to(:manage, Comment) }
        it{ should_not be_able_to(:create, Comment) }
      end

      describe "related_task model" do
        it{ should_not be_able_to(:read, RelatedTask ) }
        it{ should_not be_able_to(:manage, RelatedTask) }
        it{ should_not be_able_to(:create, RelatedTask) }
      end

      describe "time_entry model" do
        it{ should_not be_able_to(:create, TimeEntry) }
        it{ should_not be_able_to(:read, TimeEntry ) }
        it{ should_not be_able_to(:manage, TimeEntry) }
      end

      describe "customer model" do
        it{ should be_able_to(:create, Customer) }
        it{ should be_able_to(:read, Customer ) }
        it{ should be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, Contact) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should be_able_to(:create, Article) }
        it{ should be_able_to(:manage, FactoryGirl.create(:article, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:article)) }
      end
    end



    context "when it's teamleader" do
      let(:user){ FactoryGirl.create(:user, :teamleader) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "user model" do
        it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should be_able_to(:read, project) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, project) }
      end

      describe "comment model" do
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :developer, project: project)) }
        it{ should be_able_to(:create, FactoryGirl.create(:comment, :general, project: project)) }
        it{ should be_able_to(:manage, FactoryGirl.create(:comment, :general, project: project)) }

        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:comment, :commercial, project: project)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:comment, :general)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :developer)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :commercial)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:comment, :general)) }
      end

      describe "related_task model" do
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should be_able_to(:create, RelatedTask) }
        it{ should be_able_to(:manage, FactoryGirl.create(:related_task, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "time_entry model" do
        it{ should be_able_to(:create, TimeEntry) }
        it{ should be_able_to(:manage, FactoryGirl.create(:time_entry, related_task: FactoryGirl.create(:related_task, user: user))) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:time_entry)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:time_entry)) }
      end

      describe "customer model" do
        it{ should be_able_to(:read, Customer) }
        it{ should_not be_able_to(:create, Customer) }
        it{ should_not be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, Contact) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should be_able_to(:create, Article) }
        it{ should be_able_to(:manage, FactoryGirl.create(:article, user: user)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:article)) }
      end
    end



    context "when it's customer" do
      let(:user){ FactoryGirl.create(:user, :customer) }
      let!(:customer) { FactoryGirl.create(:customer) }
      let!(:contact) { FactoryGirl.create(:contact, customer: customer) }
      let!(:project) { FactoryGirl.create(:project, customer: customer) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "user model" do
        it{ should_not be_able_to(:read, User ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should be_able_to(:read, project) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, project) }
      end

      describe "comment model" do
        it{ should_not be_able_to(:read, Comment ) }
        it{ should_not be_able_to(:manage, Comment) }
        it{ should_not be_able_to(:create, Comment) }
      end

      describe "related_task model" do
        it{ should be_able_to(:read, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:create, RelatedTask) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task, project: project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:related_task)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:related_task)) }
      end

      describe "time_entry model" do
        it{ should_not be_able_to(:create, TimeEntry) }
        it{ should_not be_able_to(:read, TimeEntry ) }
        it{ should_not be_able_to(:manage, TimeEntry) }
      end

      describe "customer model" do
        it{ should be_able_to(:read, customer) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:customer)) }
        it{ should_not be_able_to(:create, Customer) }
        it{ should_not be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, contact) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:contact)) }
        it{ should_not be_able_to(:create, Contact) }
        it{ should_not be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should_not be_able_to(:create, Article) }
        it{ should_not be_able_to(:manage, Article) }
      end
    end



    context "when it's saler" do
      let(:user){ FactoryGirl.create(:user, :saler) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: user) }

      describe "user model" do
        it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
        it{ should_not be_able_to(:manage, User) }
        it{ should_not be_able_to(:create, User) }
      end

      describe "project model" do
        it{ should be_able_to(:read, project) }
        it{ should_not be_able_to(:create, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:read, FactoryGirl.create(:project)) }
        it{ should_not be_able_to(:manage, project) }
      end

      describe "comment model" do
        it{ should_not be_able_to(:read, Comment ) }
        it{ should_not be_able_to(:manage, Comment) }
        it{ should_not be_able_to(:create, Comment) }
      end

      describe "related_task model" do
        it{ should_not be_able_to(:read, RelatedTask ) }
        it{ should_not be_able_to(:manage, RelatedTask) }
        it{ should_not be_able_to(:create, RelatedTask) }
      end

      describe "time_entry model" do
        it{ should_not be_able_to(:create, TimeEntry) }
        it{ should_not be_able_to(:read, TimeEntry ) }
        it{ should_not be_able_to(:manage, TimeEntry) }
      end

      describe "customer model" do
        it{ should be_able_to(:create, Customer) }
        it{ should be_able_to(:read, Customer ) }
        it{ should be_able_to(:manage, Customer) }
      end

      describe "contact model" do
        it{ should be_able_to(:read, Contact) }
        it{ should be_able_to(:create, Contact) }
        it{ should be_able_to(:manage, Contact) }
      end

      describe "day model" do
        it{ should_not be_able_to(:read, Day) }
        it{ should_not be_able_to(:manage, Day) }
        it{ should_not be_able_to(:create, Day) }
      end

      describe "article model" do
        it{ should be_able_to(:read, Article) }
        it{ should_not be_able_to(:create, Article) }
        it{ should_not be_able_to(:manage, Article) }
      end
    end
  end
end