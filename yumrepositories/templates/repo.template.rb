[<%= title %>]
name=<%= name %>
<% if baseurl != "" %>
baseurl=<%= baseurl %>
<% else %>
mirrorlist=<%= mirrorlist %>
<% end -%>
<%if failovermethod != "" %>
failovermethod=<%= failovermethod %>
<% end -%>
enabled = <%= enabled %>
gpgcheck=<%= gpgcheck %>
<% if gpgkey != "" %>
gpgkey=<%= gpgkey %>
<% end -%>
