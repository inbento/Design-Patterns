class StudentBase
  attr_reader :id, :git, :contact
  
  def initialize(id: nil, git: nil, contact: nil)
    @id = id
    @git = git
    @contact = contact
  end
  
  def validate
    unless StudentBase.has_git?(@git)
      raise ArgumentError, "ID: #{id} Git-репозиторий не указан."
    end
    unless StudentBase.has_contact?(@contact)
      raise ArgumentError, "ID: #{id} Не указан ни один контакт."
    end
  end
  
  def self.has_git?(git)
    !git.nil? 
  end
  
  def self.has_contact?(contact)
    !contact.nil? 
  end
         
end