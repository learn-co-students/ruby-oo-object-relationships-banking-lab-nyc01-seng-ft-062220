class Transfer
  
  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  def initialize (sender, receiver, money)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = money
  end

  def status
    @status
  end
  
  def valid?
    (self.receiver.valid? && self.sender.valid?) ? true : false
  end

  #execute_transaction helper method
  def sender_sufficient_funds?
    sender_balance = self.sender.balance
    sender_balance -= self.amount
    sender_balance > 0
  end

  def execute_transaction
    return if status != "pending"
    if (sender_sufficient_funds?) && (self.valid?)
        self.sender.deposit(-self.amount)
        self.receiver.deposit(self.amount)
        self.status = "complete"
    else
      self.status = "rejected"
      "Transaction #{self.status}. Please check your account balance."
    end
  end

  def reverse_transfer 
    return if status != "complete"
    self.sender.deposit(amount)
    self.receiver.deposit(-amount)
    self.status = "reversed"
  end

end
