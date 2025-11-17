Locales = Locales or {}

Locales['en'] = {
    route_editor = 'Stop Editor',
    route_instructions = 'Go to the point and press [E] to add. Press [G] to finish.',
    npc_editor = 'NPCs',
    npc_instructions = 'Go to each NPC and press [E]. Press [G] to finish.',
    finished = 'Route creation completed successfully!',
    npc_positioned = function(index)
        return 'NPC #' .. index .. ' positioned successfully!'
    end,
    menu_title = 'Bus Route Configuration',
    menu_create_title = 'Create New Route',
    menu_create_desc = 'Create a new bus route',
    menu_edit_title = 'Edit Existing Route',
    menu_edit_desc = 'Modify or delete an existing route',
    dialog_title = 'New Route Setup',
    label_route = 'Route Label',
    label_area = 'Area',
    label_level = 'Level Required',
    label_seats = 'Seats Required',
    label_money = 'Reward - Money',
    label_exp = 'Reward - Experience',
    menu_edit_select_route = 'Select Route',
    menu_edit_select_desc = 'Edit route stops',
    menu_stop_title = function(index) return 'Stop #' .. index end,
    menu_stop_desc = 'Edit stop and NPC coordinates',
    edit_stop_title = 'Stop Editor',
    edit_stop_instruction = 'Go to the new stop location and press [E]',
    edit_npc_instruction = 'Now position the NPCs (up to 4) with [E] or finish with [G]',
    stop_updated = 'Stop Updated',
    success = 'Success',
    stop_and_npc_updated = 'Stop and NPCs updated!',
}
