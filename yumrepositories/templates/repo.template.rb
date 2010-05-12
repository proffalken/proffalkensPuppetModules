# The puppet modules contained in this package are Copyright (c) 2010 Matthew Macdonald-Wallace and are released under the GPL
# 
# "Professor Falken's Puppet Modules" is free software: you can redistribute it and/or modify 
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# "Professor Falken's Puppet Modules" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with "Professor Falken's Puppet Modules".  If not, see <http://www.gnu.org/licenses/>.
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
