Given('I am on the posts page') do
  visit "/posts"
end

Then(/^I should see a new post button$/) do
  expect(page).to have_css("a", text: "New post")
end

Then(/^I should see a posts title$/) do
  expect(page).to have_css("h1", text: "Posts")
end

When(/^I create a new post$/) do
  page.click_link("New post")
  page.fill_in("Name", with: "this is the post title")
  page.fill_in("Content", with: "this is the post content")
  page.click_button("Create Post")
end

Then(/^I should see the new post$/) do
  expect(page).to have_css("div[id=#{dom_id(Post.last)}]")
end

Then(/^I should see the post details$/) do
  expect(page).to have_current_path(post_path(Post.last))
  expect(page).to have_content(Post.last.name)
  expect(page).to have_content(Post.last.content)
end

When(/^I go back to the posts page$/) do
  page.click_link("Back to posts")
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