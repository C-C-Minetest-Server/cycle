cycle = {}

-- The version ID indicating API features.
-- Increase this number on every changes that touched
-- the behaviour of the APIs.
-- Mods can then check the compactibility by comparing
-- this value to the target version.
-- Ideally, all changes should be backward-compactible, so
-- mods should only check for a lower limit of this variable.
cycle.version = 1

local err = {}
function err.unreg(v)
	error("Please only call cycle functions after the registrations of the items!" .. v)
end

--## cycle.node APIs ##--
cycle.node = {}

function cycle.node.punchcycle(list)
	for i,v in ipairs(list) do
		local n = i + 1
		if n > #list then
			n = 1
		end

		local nodedef = minetest.registered_nodes[v]
		if not nodedef then
			err.unreg(v)
		end

		local old_on_punch = nodedef.on_punch
		local new_on_punch = function(pos, node, puncher, pointed_thing)
			node.name = list[n]
			minetest.swap_node(pos,node)
			if old_on_punch then
				return old_on_punch(pos, node, puncher, pointed_thing)
			end
		end
		minetest.override_item(v,{on_punch=new_on_punch})
	end
end

function cycle.node.rightclickcycle(list)
	for i,v in ipairs(list) do
		local n = i + 1
		if n > #list then
			n = 1
		end

		local nodedef = minetest.registered_nodes[v]
		if not nodedef then
			err.unreg(v)
		end

		local old_on_rightclick = nodedef.on_rightclick
		local new_on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			node.name = list[n]
			minetest.swap_node(pos,node)
			if old_on_rightclick then
				return old_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
			end
		end
		minetest.override_item(v,{on_rightclick=new_on_rightclick})
	end
end

--## cycle.item APIs ##--
cycle.item = {}

function cycle.item.placecycle(list)
	for i,v in ipairs(list) do
		local n = i + 1
		if n > #list then
			n = 1
		end

		local itemdef = minetest.registered_items[v]
		if not itemdef then
			err.unreg(v)
		end

		local old_on_place = itemdef.on_place
		local new_on_place = function(itemstack, placer, pointed_thing)
			itemstack:set_name(list[n])
			if old_on_place then
				return old_on_place(itemstack, placer, pointed_thing)
			end
			return itemstack
		end
		minetest.override_item(v,{on_place=new_on_place})
	end
end

function cycle.item.secondarycycle(list)
	for i,v in ipairs(list) do
		local n = i + 1
		if n > #list then
			n = 1
		end

		local itemdef = minetest.registered_items[v]
		if not itemdef then
			err.unreg(v)
		end

		local old_on_secondary_use = itemdef.on_secondary_use
		local new_on_secondary_use = function(itemstack, user, pointed_thing)
			itemstack:set_name(list[n])
			if old_on_secondary_use then
				return old_on_place(itemstack, user, pointed_thing)
			end
			return itemstack
		end
		minetest.override_item(v,{on_secondary_use=new_on_secondary_use})
	end
end

function cycle.item.usecycle(list)
	for i,v in ipairs(list) do
		local n = i + 1
		if n > #list then
			n = 1
		end

		local itemdef = minetest.registered_items[v]
		if not itemdef then
			err.unreg(v)
		end

		local old_on_place = itemdef.on_place
		local new_on_place = function(itemstack, placer, pointed_thing)
			itemstack:set_name(list[n])
			if old_on_place then
				return old_on_place(itemstack, placer, pointed_thing)
			end
			return itemstack
		end

		local old_on_secondary_use = itemdef.on_secondary_use
		local new_on_secondary_use = function(itemstack, user, pointed_thing)
			itemstack:set_name(list[n])
			if old_on_secondary_use then
				return old_on_place(itemstack, user, pointed_thing)
			end
			return itemstack
		end

		minetest.override_item(v,{on_place=new_on_place,on_secondary_use=new_on_secondary_use})
	end
end
