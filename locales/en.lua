Locales = Locales or {}

Locales['en'] = {
    --Creation Menu
    menu_title = 'Bus Route Configuration',
    menu_create_title = 'Create New Route',
    menu_create_desc = 'Create a new bus route',
    menu_edit_title = 'Edit Existing Routes',
    menu_edit_desc = 'Modify or delete an existing route',
    menu_edit_select_route = 'Select Route',
    menu_edit_select_desc = 'Edit route stops',
    menu_stop_title = function(index) return 'Stop #' .. index end,
    menu_stop_desc = 'Edit stop coordinates and NPCs',
    
    --Notifications
    route_editor = 'Stop Editor',
    route_instructions = 'Go to the point and press [E] to add. Press [G] to finish.',
    npc_editor = 'NPCs',
    npc_instructions = 'Go to each NPC and press [E]. Press [G] to finish.',
    finished = 'Route creation completed successfully!',
    npc_positioned = function(index)
        return 'NPC #' .. index .. ' positioned successfully!'
    end,
    edit_stop_title = 'Stop Editor',
    edit_stop_instruction = 'Go to the new stop location and press [E]',
    edit_npc_instruction = 'Now position the NPCs (up to 4) with [E] or finish with [G]',
    stop_updated = 'Stop Updated',
    success = 'Success',
    stop_and_npc_updated = 'Stop and NPCs updated!',

    --Route Menu
    dialog_title = 'Create new route',
    label_route = 'Route Name',
    label_area = 'Area',
    label_level = 'Required Level',
    label_seats = 'Required Seats',
    label_money = 'Reward - Money',
    label_exp = 'Reward - Experience',

    --Description
    ds_route = 'Set the name that identifies this route.',
    ds_area = 'Choose the area where the route will be used.',
    ds_level = 'Enter the minimum level required to access this route.',
    ds_seats = 'Minimum number of seats the vehicle must have.',
    ds_money = 'Amount of money received upon completing the route.',
    ds_exp = 'Amount of experience gained when finishing the route.'
}