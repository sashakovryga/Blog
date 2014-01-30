module PartsHelper
	def next_part(id)
		next_id = @chaper.parts.ids[id+1]
	end
end
