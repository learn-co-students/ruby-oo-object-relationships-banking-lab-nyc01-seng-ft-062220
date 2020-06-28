require 'pry'
class BankAccount
    attr_reader :name
    attr_accessor :balance, :status
    @@all = []
    
    def initialize(name,balance=1000,status="open")
            @name = name
            @balance = balance
            @status = status
            # @broke = 0
            @@all << self
    end
    
    def deposit(money)
        @balance += money
    end

    def self.all
        @@all
    end

    def display_balance
    #puts will return nil
    "Your balance is $#{self.balance}."
    end

    def valid?
        self.balance > 0 && status == "open"
    end

    def close_account
        self.status = "closed"
    end

end

