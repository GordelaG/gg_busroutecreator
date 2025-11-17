Locales = Locales or {}

Locales['pt'] = {
    route_editor = 'Editor de Paradas',
    route_instructions = 'Vá até o ponto e pressione [E] para adicionar. Pressione [G] para finalizar.',
    npc_editor = 'NPCs',
    npc_instructions = 'Vá até cada NPC e pressione [E]. Pressione [G] para finalizar.',
    finished = 'Criação da rota finalizada com sucesso!',
    npc_positioned = function(index)
        return 'NPC #' .. index .. ' posicionado com sucesso!'
    end,
    menu_title = 'Configuração de Rotas de Ônibus',
    menu_create_title = 'Criar Nova Rota',
    menu_create_desc = 'Crie uma nova rota de ônibus',
    menu_edit_title = 'Editar Rotas Existentes',
    menu_edit_desc = 'Modifique ou exclua uma rota existente',
    dialog_title = 'Nova Rota',
    label_route = 'Nome da Rota',
    label_area = 'Área',
    label_level = 'Nível Necessário',
    label_seats = 'Assentos Necessários',
    label_money = 'Recompensa - Dinheiro',
    label_exp = 'Recompensa - Experiência',
    menu_edit_select_route = 'Selecionar Rota',
    menu_edit_select_desc = 'Editar paradas da rota',
    menu_stop_title = function(index) return 'Parada #' .. index end,
    menu_stop_desc = 'Editar coordenadas da parada e NPCs',
    edit_stop_title = 'Editor de Parada',
    edit_stop_instruction = 'Vá até o novo local da parada e pressione [E]',
    edit_npc_instruction = 'Agora posicione os NPCs (até 4) com [E] ou finalize com [G]',
    stop_updated = 'Parada Atualizada',
    success = 'Sucesso',
    stop_and_npc_updated = 'Parada e NPCs atualizados!',
}
