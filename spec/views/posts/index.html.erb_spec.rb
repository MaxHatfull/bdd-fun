require "rails_helper"

describe "posts/index.html.erb" do
  let(:posts) { [
    Post.create!(name: "slicer", content: "stuff"),
    Post.create!(name: "dicer", content: "more content")
  ] }

  before do
    assign(:posts, posts)

    render
  end

  it "displays all the widgets" do
    expect(rendered).to have_content("slicer")
    expect(rendered).to have_content("stuff")
    expect(rendered).to have_link("Show this post", href: post_path(posts.first))

    expect(rendered).to have_content("dicer")
    expect(rendered).to have_content("more content")
    expect(rendered).to have_link("Show this post", href: post_path(posts.last))
  end

  it "has a link to create a new post" do
    expect(rendered).to have_link("New post", href: new_post_path)
  end
end