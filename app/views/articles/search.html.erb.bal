<!--<p id="notice"><%#= notice %></p>
<%# breadcrumbs  %>
<h1>Listing Articles</h1>

<table>
  <thead>
    <tr>
      <th>Category</th>
      <th>Title</th>
      <th>Description</th>
      <th>Content</th>
      
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <%# @articles.limit(20).each do |article| %>
      <tr>
        <td><%#= article.category %></td>
        <td><%= article.eyecatch_img.html_safe %></td>
        <td><%= article.title %></td>
        <td><%= article.description %></td>
        <td><%#= article.content %></td>
        <td><%= article.user.name %></td>
        <td><%= link_to 'Show', article %></td>
        <td><%= link_to 'Edit', edit_article_path(article) %></td>
        <td><%= link_to 'Destroy', article, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <%# end %>
  </tbody>
</table>

<br>

<%#= link_to 'New Article', new_article_path %>
-->
<%= render "inarticle" %>

