FactoryBot.define do 

  factory :admin_user, class: User do
    username "admin_user"
    email "admin_user@toto.com"
    password "admin1234"
    language "en"
    roles [ :admin ]
  end

  factory :pilot_user, class: User do
    username "pilot_user"
    email "pilot_user@toto.com"
    password "pilot1234"
    language "en"
    roles [ :pilot ]
  end

  factory :new_user, class: User do
    username "new_user"
    email "new_user@toto.com"
    password "new_user1234"
    language "en"
    roles [ ]
  end

  trait :password do 
    encrypted_password User.new.send(:password_digest, password)
  end    

  factory :building do
    name "Building 101"
    short_name "Bldg 101"
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'bldg.jpg'), 'image/jpg') }
    min_level 1
    max_level 2
  end

  factory :floor_image do
    level 1
    name "Level 1"
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'floor.png'), 'image/png') }
    building
  end

  factory :wing do
    name "Wing 1"
    short_name "Wg 1"
    building 
  end

  factory :floor do
    name "Floor 1"
    level 1
    drawing { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'floor.png'), 'image/png') }
    wing
    building { wing.building }
  end

  factory :space do
    name "Space 1"
    coor "1,1,20,20"
    figure "R"  # R for Rectangle, P for polynomial
    floor
  end

  factory :space_type do
    name "Space Type"
    # space space_type: this
  end
end
