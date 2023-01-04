Given('I am on the posts page') do
  visit "/posts"
end

When(/^I create a new post$/) do
  page.click_link("New post")
  page.fill_in("Name", with: "this is the post title")
  page.fill_in("Content", with: "this is the post content")
  page.click_button("Create Post")

  expect(page).to have_content("this is the post title")
end

Then(/^I should see the new post$/) do
  expect(page).to have_css("div[id=#{dom_id(Post.last)}]")
end

Then(/^I should see the post details$/) do
  expect(page).to have_current_path(post_path(Post.last))
  expect(page).to have_content(Post.last.name)
  expect(page).to have_content(Post.last.content)
end

Then(/^I see the latest post in the list$/) do
  expect(page).to have_current_path(posts_path)

  expect(page).to have_content(Post.last.name)
  expect(page).to have_content(Post.last.content)
  expect(page).to have_css("a[href='#{post_path(Post.last)}']")
end

When(/^I delete the latest post$/) do
  page.find("a[href='#{post_path(Post.last)}']").click
  page.click_button("Destroy this post")
end

Then(/^The list of posts is empty$/) do
  expect(page).to have_current_path(posts_path)

  expect(page).not_to have_css("div[id^='post_']")
end

Given(/^There is an existing post$/) do
  Post.create!(name: "Interesting name", content: "some text content")
end

Given(/^I am on the latest post page$/) do
  visit(post_path(Post.last))
end

When(/^I create a comment$/) do
  expect(page).to have_current_path(post_path(Post.last))
  within(page.find("div[id='new_comment_form']")) do
    fill_in("Content", with: "interesting comment")
    click_on "Create Comment"
  end
  expect(page).to have_content("interesting comment")
end

Then(/^I can see the comment$/) do
  last_comment = page.find("div[id=#{dom_id(Comment.last)}]")
  expect(last_comment).to have_content("interesting comment")
end

When(/^I delete the comment$/) do
  within(page.find("div[id=#{dom_id(Comment.last)}]")) do
    click_on "Delete Comment"
  end
end

Then(/^I can not see any comments$/) do
  expect(page).to have_current_path(post_path(Post.last))

  expect(page).not_to have_css("div[id^='comment_']")
end

Given(/^js is (.*)$/) do |with_js|
  case with_js
  when "true"
    Capybara.current_driver = :selenium_chrome_headless
  else
    Capybara.current_driver = :rack_test
  end
end