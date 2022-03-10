require "rails_helper"

RSpec.describe Room, type: :model do
  current_user = User.first_or_create!(email: "ashish_mainali@gmail.com", password: "password", username: "ashish",
                                       role: "admin", address: "new york", contact: "976543210")
  current_user.confirm
  it "has a description" do
    room = Room.new(
      description: "",
      user: current_user
    )
    expect(room).to_not be_valid
    room.description = "Ongoing meeting is about Unit testing with Traniee team"
    expect(room).to be_valid
  end

  it "has a description at least 5 characters long" do
    room = Room.new(
      description: "ab",
      user: current_user
    )
    expect(room).to_not be_valid
    room.description = "Resolve the war in between ukarine and russia. What is the option to resolve it?"
    expect(room).to be_valid
  end

  it "has a description between 5 to 300 characters long" do
    room = Room.new(
      description: "desc",
      user: current_user
    )
    expect(room).to_not be_valid

    room.description = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
     Aenean mLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean m"
    expect(room).to be_valid
    room.description = "This online tool can generate up to ten thousand random strings where every string is a maximum
     of 100 characters in length. The random strings you generate can be outputted in a format where every string is on
     a separate line or the strings are separated by commas. You can also output the strings so that they can be easily
     used as a csv file This online tool can generate up to ten thousand random strings where every string is a maximum
     characters in length. The random strings you generate can be outputted in a format where every string is on a
     separate line or the strings are separated by commas. You can also output the strings so that they can be easily
     file This online tool can generate up to ten thousand random strings where every string is a maximum of 100
     characters in length. The random strings you generate can be outputted in a format where every string is on a
     or the strings are separated by commas. You can also output the strings so that they can be easily used as a csv
     file. This online tool can generate up to ten thousand random strings where every string is a maximum of 100
     length. The random strings you generate can be outputted in a format where every string is on a separate line or
     strings are separated by commas. You can also output the strings so that they can be easily used as a csv file
     online tool can generate up to ten thousand random strings where every string is a maximum of 100 characters in
     length. The random strings you generate can be outputted in a format where every string is on a separate line
     the strings are separated by commas. You can also output the strings so that they can be easily used as a csv
     in length. The random strings you generate can be outputted in a format where every string is on a separate
     or the strings are separated by commas. You can also output the strings so that they can be easily used as a
     file"
    expect(room).to_not be_valid
  end
end
