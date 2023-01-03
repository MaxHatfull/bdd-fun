require "rails_helper"

describe "posts/show.html.erb" do
  let(:post) {
    Post.create!(name: "slicer", content: "stuff").tap do |p|
      p.comments << Comment.create!(content: "commentary", post: p)
    end
  }

  before do
    assign(:post, post)

    render
  end

  it "displays the post info" do
    expect(rendered).to have_content("slicer")
    expect(rendered).to have_content("stuff")
  end

  it "displays the post comment" do
    expect(rendered).to have_content("commentary")
  end
end