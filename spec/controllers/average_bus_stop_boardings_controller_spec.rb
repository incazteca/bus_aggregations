require 'rails_helper'

RSpec.describe AverageBusStopBoardingsController, type: :controller do
  describe 'GET #index' do
    let(:default_params) do
      {
        aggregate: {
          field: 'boardings',
          function: 'count',
          group: 'routes',
          limit: 20,
          offset: 0
        }
      }
    end

    before { get(:index, params: default_params) }

    it { is_expected.to render_template 'index' }
  end
end
