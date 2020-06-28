require 'pry'
class Transfer

  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  @@all = []
  
  def initialize(sender,receiver, status='pending', amount)
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
    @@all << self 
  end

  def valid?
    sender.valid?
    receiver.valid?
  end

  def self.all
    @@all
  end

  


  def execute_transaction
    if self.valid? && amount < @sender.balance && self.status != "complete"
      
      @sender.balance -= amount
      @receiver.balance += amount
      self.status = "complete"  
    else
      self.status = "rejected"
        "Transaction rejected. Please check your account balance."
      end 

  end 

  def reverse_transfer

    last_transaction = Transfer.all.pop

    if (self.valid? || amount > @sender.balance) && (last_transaction.status == "complete") 
      # not that elegant... it would be best to save all the transactions in a hash like a transaction history. 
      @sender.balance += last_transaction.amount
      @receiver.balance -= last_transaction.amount
       self.status = "reversed"
    else
      return "Whoops something went wrong"
    end 
  end
 
   

end

# amanda = BankAccount.new("Amanda") 
#  avi = BankAccount.new("Avi")
#  transfer = Transfer.new(amanda, avi, 50)
#  transfer.execute_transaction
#    binding.pry
#    0