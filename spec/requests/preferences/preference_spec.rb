# frozen_string_literal: true

require 'rails_helper'

describe 'Preferences' do
  let(:user) { create(:user) }
  let(:preference) { build(:preference) }
  let(:params) { { preference: preference.attributes } }

  before { sign_in user }

  describe 'POST create' do
    subject { post preferences_path, params: }

    context 'when success' do
      it 'creates the preference' do
        expect { subject }.to change(Preference, :count).by(1)
      end

      it 'have http status 302' do
        expect(subject).to eq(302)
      end

      it 'redirect to index' do
        expect(subject).to redirect_to(preferences_path)
      end
    end

    context 'when fails' do
      let(:preference) { build(:preference, name: nil) }

      it 'does not create the preference' do
        expect { subject }.not_to change(Preference, :count)
      end

      it 'have http status 422' do
        expect(subject).to eq(422)
      end
    end
  end
end
