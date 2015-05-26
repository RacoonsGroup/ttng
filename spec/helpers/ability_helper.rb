shared_examples 'can manage' do |models|
  models.each do |model|
    it{ should be_able_to(:read, model) }
    it{ should be_able_to(:manage, model) }
    it{ should be_able_to(:create, model) }
  end
end

shared_examples 'can manage without create' do |models|
  models.each do |model|
    it{ should be_able_to(:read, model) }
    it{ should be_able_to(:manage, model) }
    it{ should_not be_able_to(:create, model) }
  end
end

shared_examples 'can read available user' do
  it{ should be_able_to(:read, FactoryGirl.create(:user, :chief)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :developer)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :manager)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :hr)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :buh)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :teamleader)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :customer)) }
  it{ should be_able_to(:read, FactoryGirl.create(:user, :saler)) }
  it{ should_not be_able_to(:read, FactoryGirl.create(:user, :nobody) ) }
  it{ should_not be_able_to(:manage, User) }
  it{ should_not be_able_to(:create, User) }
end

shared_examples 'can read only this project' do
  it{ should be_able_to(:read, project) }
  it{ should_not be_able_to(:create, FactoryGirl.create(:project)) }
  it{ should_not be_able_to(:manage, FactoryGirl.create(:project)) }
  it{ should_not be_able_to(:read, FactoryGirl.create(:project)) }
  it{ should_not be_able_to(:manage, project) }
end

shared_examples 'manage own time entries' do
  it{ should be_able_to(:create, TimeEntry) }
  it{ should be_able_to(:manage, FactoryGirl.create(:time_entry, related_task: FactoryGirl.create(:related_task, user: user))) }
  it{ should_not be_able_to(:manage, FactoryGirl.create(:time_entry)) }
  it{ should_not be_able_to(:read, FactoryGirl.create(:time_entry)) }
end

shared_examples 'can nothing' do |models|
  models.each do |model|
    it{ should_not be_able_to(:read, model) }
    it{ should_not be_able_to(:manage, model) }
    it{ should_not be_able_to(:create, model) }
  end
end

shared_examples 'can read and create articles' do
  it{ should be_able_to(:read, Article) }
  it{ should be_able_to(:create, Article) }
  it{ should be_able_to(:manage, FactoryGirl.create(:article, user: user)) }
  it{ should_not be_able_to(:manage, FactoryGirl.create(:article)) }
end

shared_examples 'can read' do |models|
  models.each do |model|
    it{ should be_able_to(:read, model) }
    it{ should_not be_able_to(:manage, model) }
    it{ should_not be_able_to(:create, model) }
  end
end
