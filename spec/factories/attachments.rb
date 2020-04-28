FactoryBot.define do
  factory :attachment do
    file do
      Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec', 'rails_helper.rb')
      )
    end
  end
end
