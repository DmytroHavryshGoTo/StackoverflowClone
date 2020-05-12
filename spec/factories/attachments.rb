FactoryBot.define do
  factory :attachment do
    attachable { |a| a.association(:answer) }
    file do
      Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec', 'rails_helper.rb')
      )
    end
  end
end
