module Validation
  def validation_name(name)
    (name.is_a? String) && !name.empty? && name.length.between?(3, 20)
  end

  def validation_guess(guess)
    /^[1-6]{4}$/.match?(guess)
  end
end
