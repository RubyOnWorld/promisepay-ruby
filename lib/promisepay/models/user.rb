
module Promisepay
  # Manage Users
  class User < BaseModel
    # Update the attributes of an item.
    #
    # @see https://reference.promisepay.com/#update-item
    #
    # @param attributes [Hash] Item's attributes to be updated.
    #
    # @return [self]
    def update(attributes)
      response = JSON.parse(@client.patch("users/#{send(:id)}", attributes).body)
      @attributes = response['users']
      self
    end

    # Lists items for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#list-user-items
    #
    # @return [Array<Promisepay::Item>]
    def items
      response = JSON.parse(@client.get("users/#{send(:id)}/items").body)
      users = response.key?('items') ? response['items'] : []
      users.map { |attributes| Promisepay::Item.new(@client, attributes) }
    end

    # Gets Bank account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#show-user-bank-account
    #
    # @return [Promisepay::BankAccount]
    def bank_account
      response = JSON.parse(@client.get("users/#{send(:id)}/bank_accounts").body)
      Promisepay::BankAccount.new(@client, response['bank_accounts'])
    rescue Promisepay::UnprocessableEntity
      nil
    end

    # Gets Card account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#show-user-card-account
    #
    # @return [Promisepay::CardAccount]
    def card_account
      response = JSON.parse(@client.get("users/#{send(:id)}/card_accounts").body)
      Promisepay::CardAccount.new(@client, response['card_accounts'])
    rescue Promisepay::UnprocessableEntity
      nil
    end

    # Gets PayPal account for a user on a marketplace.
    #
    # @see https://reference.promisepay.com/#show-user-paypal-account
    #
    # @return [Promisepay::PaypalAccount]
    def paypal_account
      response = JSON.parse(@client.get("users/#{send(:id)}/paypal_accounts").body)
      Promisepay::PaypalAccount.new(@client, response['paypal_accounts'])
    rescue Promisepay::UnprocessableEntity
      nil
    end

    # Show the User???s Wallet Account.
    #
    # @see https://reference.promisepay.com/#show-user-wallet-account
    #
    # @return [Promisepay::WalletAccount]
    def wallet_account
      response = JSON.parse(@client.get("users/#{send(:id)}/wallet_accounts").body)
      Promisepay::WalletAccount.new(@client, response['wallet_accounts'])
    rescue Promisepay::UnprocessableEntity
      nil
    end

    # Set the disbursement account for a user.
    #
    # @see https://reference.promisepay.com/#set-user-disbursement-account
    #
    # @return [Boolean]
    def disbursement_account(account_id)
      options = { account_id: account_id }
      JSON.parse(@client.post("users/#{send(:id)}/disbursement_account", options).body)
      true
    end

    # Gets company for a user on a marketplace.
    #
    # @see
    #
    # @return [Promisepay::Company]
    def company
      response = JSON.parse(@client.get("users/#{send(:id)}/companies").body)
      Promisepay::Company.new(@client, response['companies'])
    rescue Promisepay::NotFound
      nil
    end

    # Gets user address.
    #
    # @see https://reference.promisepay.com/#addresses
    #
    # @return [Hash]
    def address
      return nil unless @attributes.key?('related')
      response = JSON.parse(@client.get("addresses/#{send(:related)['addresses']}").body)
      response['addresses']
    end
  end
end
