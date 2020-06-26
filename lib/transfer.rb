class Transfer

  attr_accessor :sender,:receiver,:status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver 
    @amount = amount 
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if valid? && @sender.balance > @amount
      @sender.balance -= @amount 
      @receiver.balance += @amount
      @status = "complete"
      @prev_amount = @amount
      @amount = 0
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.balance += @prev_amount 
      @receiver.balance -= @prev_amount 
      @status = "reversed"
    end
  end

end
