 
# frozen_string_literal: true

require 'application_system_test_case'

class SecretSantaTest < ApplicationSystemTestCase
  test 'secret santa' do
    # When I start a game
    visit '/'
    assert_selector 'h1', text: 'Simple Secret Santa!'
    fill_in 'Person 1', with: 'Josh'
    fill_in 'Person 2', with: 'Ez'
    fill_in 'Person 3', with: 'Rosie'
    click_button 'Start'

    # Then I see the game has started
    assert_selector 'h1', 'The elves have chosen!'
    share_url = page.url

    # And I see nobody has seen who to buy a present for
    assert_selector 'h2', text: 'Josh has not seen who to buy a present for'
    assert_selector 'h2', text: 'Ez has not seen who to buy a present for'
    assert_selector 'h2', text: 'Rosie has not seen who to buy a present for'

    # When I reveal who to buy a present for
    click_link 'I am Josh'
    click_button 'I am sure, I am definitely Josh'

    # Then I see who to buy a present for
    assert_selector 'h1', text: 'Josh, you need to buy a present for Rosie'

    # Then everybody can see that I have seen who to buy a present for
    visit share_url
    assert_selector 'h2', text: 'Josh has seen who to buy a present for'
    assert_selector 'h2', text: 'Ez has not seen who to buy a present for'
    assert_selector 'h2', text: 'Rosie has not seen who to buy a present for'

    # When everybody else reveals who to buy presents for
    visit share_url
    click_link 'I am Ez'
    click_button 'I am sure, I am definitely Ez'
    assert_selector 'h1', text: 'Ez, you need to buy a present for Josh'
    visit share_url
    click_link 'I am Rosie'
    click_button 'I am sure, I am definitely Rosie'
    assert_selector 'h1', text: 'Rosie, you need to buy a present for Ez'

    # Then everybody can see that everybody knows what to do
    visit share_url
    assert_selector 'h2', text: 'Josh has seen who to buy a present for'
    assert_selector 'h2', text: 'Ez has seen who to buy a present for'
    assert_selector 'h2', text: 'Rosie has seen who to buy a present for'
  end
end
