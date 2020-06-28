class Transfer
    attr_accessor :sender, :receiver, :amount, :status
    @@all = []

    def initialize(sender,receiver,amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @@all << self
    end

    def valid?
      @sender.valid? && @receiver.valid?
    end

    def execute_transaction
      if self.valid? && sender.balance >= amount && @status == "pending"
        @status = "complete"
        sender.deposit(-@amount)
        receiver.deposit(@amount)
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end

    def reverse_transfer
      if @status == "complete"
        sender.deposit(@amount)
        receiver.deposit(-@amount)
        @status = "reversed"
      end
    end




end
