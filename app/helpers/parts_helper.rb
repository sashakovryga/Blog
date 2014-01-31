module PartsHelper
	def next_part(id)
		id_key = @chaper.parts.ids.index(id)
		next_id = @chaper.parts.ids[id_key].next
	end
end
