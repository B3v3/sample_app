module UsersHelper
  #returns the gravatar for user
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
end
    def number_to_word(int) #for error messages
      numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight"]
      number = numbers[int - 1]
      return number
end
end
