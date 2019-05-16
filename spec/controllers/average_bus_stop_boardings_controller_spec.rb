# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AverageBusStopBoardingsController, type: :controller do
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

  describe 'GET #index' do
    before { get(:index, params: default_params) }

    it { is_expected.to render_template 'index' }

    it 'assigns aggregate fields' do
      expect(assigns[:aggregate_functions]).to eq %w[count sum average minimum maximum]
      expect(assigns[:aggregate_fields]).to eq %w[boardings alightings]
      expect(assigns[:aggregate_groups]).to eq %w[routes intersection]
      expect(assigns[:aggregate_limits]).to eq [20, 50, 100]
      expect(assigns[:default_params]).to eq default_params
    end
  end

  describe 'GET #aggregation' do
    before do
      create(:addison_route, cross_street: 'HARLEM', boardings: 40, alightings: 5)
      create(:addison_route, cross_street: 'OAK PARK', boardings: 30, alightings: 10)
      create(:addison_route, cross_street: 'NORMANDY', boardings: 20, alightings: 15)
      create(:addison_route, cross_street: 'NEENAH', boardings: 10, alightings: 20)

      create(:harlem_route, cross_street: 'ADDISON', boardings: 60, alightings: 30)
      create(:harlem_route, cross_street: 'IRVING PARK', boardings: 20, alightings: 10)
    end

    it 'gets aggregation on routes' do
      get :aggregation, params: default_params
      expect(JSON.parse(@response.body)).to eq [['152', 4], ['90', 2]]
    end

    it 'gets aggregation on intersection' do
      intersection_params = default_params.deep_dup
      intersection_params[:aggregate][:group] = 'intersection'

      get :aggregation, params: intersection_params
      expect(JSON.parse(@response.body)).to eq [
        ['ADDISON & HARLEM', 2],
        ['ADDISON & NEENAH', 1],
        ['ADDISON & NORMANDY', 1],
        ['ADDISON & OAK PARK', 1],
        ['HARLEM & IRVING PARK', 1]
      ]
    end
  end
end
