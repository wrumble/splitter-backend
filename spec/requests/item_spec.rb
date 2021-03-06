describe 'items API' do

  let(:json) { JSON.parse(response.body) }
  let(:bill_with_items) { create(:bill_with_items) }
  let(:bill) { create(:bill) }
  let(:item) { create(:item) }

  describe '#index' do
    it 'sends list of items for Bill' do
      get bill_items_path(bill_with_items)
      expect(response).to be_success
      expect(json.length).to eq 5
    end
  end

  describe '#create' do
    it 'creates an item' do
      params = {name:"jack", price:1, quantity:1}
      post bill_items_path(bill), {item: params}
      expect(response).to be_success
      expect(Item.count).to eq 1
    end
  end

  describe '#delete' do
    it 'deletes an item' do
      delete delete_item_path(bill.id, item.id)
      expect(response).to be_success
      expect(Item.count).to eq 0
    end
  end

  describe '#update' do
    it 'updates an item with contact details' do
      params = {contact:"email@gmail.com"}
      patch bill_item_path(bill.id, item.id), { item: params }
      expect(response).to be_success
      expect(Item.last.contact).to eq "email@gmail.com"
    end
  end
end
