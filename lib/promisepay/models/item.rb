module Promisepay
  # Manage Items
  class Item < BaseModel
    # Update the attributes of an item.
    #
    # @see https://reference.promisepay.com/#update-item
    #
    # @param attributes [Hash] Item's attributes to be updated.
    #
    # @return [self]
    def update(attributes)
      response = JSON.parse(@client.patch("items/#{send(:id)}", attributes).body)
      @attributes = response['items']
      self
    end

    # Show the item status for a marketplace.
    #
    # @see https://reference.promisepay.com/#show-item-status
    #
    # @return [Hash]
    def status
      response = JSON.parse(@client.get("items/#{send(:id)}/status").body)
      response['items']
    end

    # Show the buyer detail for a single item for a marketplace.
    #
    # @see https://reference.promisepay.com/#show-item-buyer
    #
    # @return [Promisepay::User]
    def buyer
      response = JSON.parse(@client.get("items/#{send(:id)}/buyers").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Show the seller detail for a single item for a marketplace.
    #
    # @see https://reference.promisepay.com/#show-item-seller
    #
    # @return [Promisepay::User]
    def seller
      response = JSON.parse(@client.get("items/#{send(:id)}/sellers").body)
      Promisepay::User.new(@client, response['users'])
    end

    # Get fees associated to the item.
    #
    # @see https://reference.promisepay.com/#show-item-fees
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 fees. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Fee>]
    def fees(options = {})
      response = JSON.parse(@client.get("items/#{send(:id)}/fees", options).body)
      fees = response.key?('fees') ? response['fees'] : []
      fees.map { |attributes| Promisepay::Fee.new(@client, attributes) }
    end

    # Get historical transactions for the item.
    #
    # @see https://reference.promisepay.com/#list-item-transactions
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 transactions. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::Transaction>]
    def transactions(options = {})
      response = JSON.parse(@client.get("items/#{send(:id)}/transactions", options).body)
      transactions = response.key?('transactions') ? response['transactions'] : []
      transactions.map { |attributes| Promisepay::Transaction.new(@client, attributes) }
    end

    # Get historical batch_transactions for the item.
    #
    # @see https://reference.promisepay.com/#list-item-batch-transactions
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :limit Can ask for up to 200 transactions. default: 10
    # @option options [Integer] :offset Pagination help. default: 0
    #
    # @return [Array<Promisepay::BatchTransaction>]
    def batch_transactions(options = {})
      response = JSON.parse(@client.get("items/#{send(:id)}/batch_transactions", options).body)
      batch_transactions = response.key?('batch_transactions') ? response['batch_transactions'] : []
      batch_transactions.map { |attributes| Promisepay::BatchTransaction.new(@client, attributes) }
    end

    # Show the wire details for payment.
    #
    # @see https://reference.promisepay.com/#show-item-wire-details
    #
    # @return [Hash]
    def wire_details
      response = JSON.parse(@client.get("items/#{send(:id)}/wire_details").body)
      response['items']['wire_details']
    end

    # Show the bpay details details for payment.
    #
    # @see https://reference.promisepay.com/#show-item-bpay-details
    #
    # @return [Hash]
    def bpay_details
      response = JSON.parse(@client.get("items/#{send(:id)}/bpay_details").body)
      response['items']['bpay_details']
    end

    # Make a payment for an Item.
    #
    # @see https://reference.promisepay.com/#make-payment
    #
    # @return [Boolean]
    def make_payment(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/make_payment", options).body)
      @attributes = response['items']
      true
    end

    # Request payment for an Item.
    #
    # @see https://reference.promisepay.com/#request-payment
    #
    # @return [Boolean]
    def request_payment(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/request_payment", options).body)
      @attributes = response['items']
      true
    end

    # Release funds held in escrow from an Item with an Escrow or Escrow Partial Release
    # payment type.
    #
    # @see https://reference.promisepay.com/#release-payment
    #
    # @return [Boolean]
    def release_payment(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/release_payment", options).body)
      @attributes = response['items']
      true
    end

    # Request release of funds held in escrow, from an Item with an Escrow or Escrow Partial
    # Release payment type.
    #
    # @see https://reference.promisepay.com/#request-release
    #
    # @return [Boolean]
    def request_release(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/request_release", options).body)
      @attributes = response['items']
      true
    end

    # Acknowledge that funds are being wired for payment.
    #
    # @see https://reference.promisepay.com/#acknowledge-wire-transfer
    #
    # @return [Boolean]
    def acknowledge_wire(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/acknowledge_wire", options).body)
      @attributes = response['items']
      true
    end

    # .
    #
    # @see http://docs.promisepay.com/v2.2/docs/itemsidacknowledge_paypal
    #
    # @return [Boolean]
    def acknowledge_paypal(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/acknowledge_paypal", options).body)
      @attributes = response['items']
      true
    end

    # Revert an acknowledge wire Item Action.
    #
    # @see https://reference.promisepay.com/#revert-wire-transfer
    #
    # @return [Boolean]
    def revert_wire(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/revert_wire", options).body)
      @attributes = response['items']
      true
    end

    # Request a refund for an Item.
    #
    # @see https://reference.promisepay.com/#request-refund
    #
    # @return [Boolean]
    def request_refund(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/request_refund", options).body)
      @attributes = response['items']
      true
    end

    # Decline a refund request for an Item.
    #
    # @see https://reference.promisepay.com/#decline-refund
    #
    # @return [Boolean]
    def decline_refund
      response = JSON.parse(@client.patch("items/#{send(:id)}/decline_refund").body)
      @attributes = response['items']
      true
    end

    # Refund an Item???s funds held in escrow.
    #
    # @see https://reference.promisepay.com/#refund
    #
    # @return [Boolean]
    def refund(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/refund", options).body)
      @attributes = response['items']
      true
    end

    # Raise a dispute for the Item.
    #
    # @see https://reference.promisepay.com/#raise-dispute
    #
    # @return [Boolean]
    def raise_dispute(options = {})
      response = JSON.parse(@client.patch("items/#{send(:id)}/raise_dispute", options).body)
      @attributes = response['items']
      true
    end

    # Request that the dispute be resolved.
    #
    # @see https://reference.promisepay.com/#request-dispute-resolution
    #
    # @return [Boolean]
    def request_resolve_dispute
      response = JSON.parse(@client.patch("items/#{send(:id)}/request_resolve_dispute").body)
      @attributes = response['items']
      true
    end

    # Resolve a dispute.
    #
    # @see https://reference.promisepay.com/#resolve-dispute
    #
    # @return [Boolean]
    def resolve_dispute
      response = JSON.parse(@client.patch("items/#{send(:id)}/resolve_dispute").body)
      @attributes = response['items']
      true
    end

    # Escalate a dispute raised against an Item.
    #
    # @see https://reference.promisepay.com/#escalate-dispute
    #
    # @return [Boolean]
    def escalate_dispute
      response = JSON.parse(@client.patch("items/#{send(:id)}/escalate_dispute").body)
      @attributes = response['items']
      true
    end

    # Cancel an Item.
    #
    # @see https://reference.promisepay.com/#cancel
    #
    # @return [Boolean]
    def cancel
      response = JSON.parse(@client.patch("items/#{id}/cancel").body)
      @attributes = response['items']
      true
    end

    # Email a Tax Invoice to the Users associated with the Item.
    #
    # @see https://reference.promisepay.com/#send-tax-invoice
    #
    # @return [Boolean]
    def send_tax_invoice
      response = JSON.parse(@client.patch("items/#{send(:id)}/send_tax_invoice").body)
      @attributes = response['items']
      true
    end

    # Request a Tax Invoice be sent to the Users associated with an Item.
    #
    # @see https://reference.promisepay.com/#request-tax-invoice
    #
    # @return [Boolean]
    def request_tax_invoice
      response = JSON.parse(@client.patch("items/#{send(:id)}/request_tax_invoice").body)
      @attributes = response['items']
      true
    end
  end
end
