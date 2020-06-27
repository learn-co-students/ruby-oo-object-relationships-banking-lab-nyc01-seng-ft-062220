class Transfer
  attr_accessor :sender, :receiver, :status, :transfer_amount

  def initialize(sender, receiver, transfer_amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @transfer_amount = transfer_amount
  end

  def amount
    @transfer_amount = 50
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @sender.balance > @transfer_amount && self.valid? && @status == "pending"
      @receiver.balance += @transfer_amount 
      @sender.balance -= @transfer_amount
      @status = "complete"
    else #@sender.balance < @transfer_amount && @sender.valid? == 'false' || @receiver.valid? == 'false'
      @status = "rejected" 
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    self.execute_transaction
    @receiver.balance -= @transfer_amount 
    @sender.balance += @transfer_amount
    @status = "reversed"
  end
  
end