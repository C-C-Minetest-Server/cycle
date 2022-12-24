## Rightclick to change state... How to?
This mod provides an easy way to register block or item state change on certain events. Unless otherwise specified, all calls should be called after the node/item registrations.

### `cycle.node` APIs
This table provides cycle functions for nodes.

#### `cycle.node.punchcycle(list)`
Enter the node names in order to the list. Nodes, when being punched, will change to the next state, or the first state if that node is the last one.

This function will override `nodedef.on_punch`. Functions originally exists will be executed afterwards.

#### `cycle.node.rightclickcycle(list)`
Enter the node names in order to the list. Nodes, when being right-clicked, will change to the next state, or the first state if that node is the last one.

This function will override `nodedef.on_rightclick`. Functions originally exists will be executed afterwards.

### `cycle.item` APIs
This table provides cycle functions for items, including nodes in item form.

#### `cycle.item.usecycle(list)`
Enter the node names in order to the list. When the player right-clicks when holding one of the listed items, the item will change to the next state, or the first state if that item is the last one.

This function will override `itemdef.on_place` and `itemdef.on_secondary_use`. Functions originally exists will be executed afterwards. This should not be used on node items.

#### `cycle.item.placecycle(list)`
With similar behavior as `cycle.item.usecycle(list)`, but will only do the loop if the player was pointing to a node.

This function will override `itemdef.on_place`. Functions originally exists will be executed afterwards. This should not be used on node items.

#### `cycle.item.secondarycycle(list)`
With similar behavior as `cycle.item.usecycle(list)`, but will only do the loop if the player was not pointing to a node.

This function will override `itemdef.on_secondary_use`. Functions originally exists will be executed afterwards.

#### `cycle.item.usecycle(list)`
Enter the node names in order to the list. When the player left-clicks when holding one of the listed items, the item will change to the next state, or the first state if that item is the last one.

This function will override `itemdef.on_use`. Functions originally exists will be executed afterwards.


### Variables
#### `cycle.version`
The version ID indicating API features. This number is increased on every changes that touched the behaviour of the APIs. Mods can then check the compactibility by comparing this value to the target version.

Ideally, all changes should be backward-compactible, so mods should only check for a lower limit of this variable.
