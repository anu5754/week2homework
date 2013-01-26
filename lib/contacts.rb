##
# class to manage list of contacts
#
class Contacts

  ##
  # create a Contacts object from string of pipe delimited ("|") fields, one record per line
  # e.g. "Brandon Faloona|Seattle|WA|bfaloona@uw.edu\nBarack Obama|Washington|DC|president@wh.gov"
  #
  def initialize data
    @raw_entries = data.split("\n")
    @contacts = @raw_entries.collect do |line|
      fieldname = line.split("|")
      {full_name: fieldname[0], city: fieldname[1], state: fieldname[2], email: fieldname[3]}
    end
  end

  def raw_entries
    @raw_entries
  end

  ##
  # return a comma separated list of formatted email addresses
  #
  def email_list
    @raw_entries.collect do |line|
      name, city, state, email = line.split("|")
      format_email_address name, email.chomp
    end.join(", ")
  end

  ##
  # returns "Display Name" <email@address> given name and email
  #
  def format_email_address name, email
    %{\"#{name}\" <#{email}>}
  end

  #########

  # returns "Number of Contact we are entering"
  #

  def num_entries
    @contacts.count
  end


  def fields
    @contacts[0].keys
  end

  # returns "A hash for the contact at index"
  #
  def contact index
    @contacts.fetch(index)
  end

  def format_contact contact
    output =  '"'+ contact[:full_name] + " of " + contact[:city] + " " + contact[:state] + '"' + " <"+contact[:email]+">"
    return output
  end

  def all
    @contacts
  end

  def formatted_list
    @contacts.map {|val| format_contact val }.join("\n")
  end

  def full_names
    @contacts.collect {|val| val[:full_name]}
  end

  def cities
    @contacts.collect {|val| val[:city]}.uniq
  end

  def append_contact contact
    @contacts << contact
  end

  def delete_contact index
    @contacts.delete_at(index)
  end

  def search string
    @contacts.select{|val| val.has_value?(string)}
  end

  def all_sorted_by fields
    @contacts.sort_by{|val| val[fields]}
  end
  
end
