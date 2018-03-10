def encrypt input
	key = (('a'..'z').to_a + ('A'..'D').to_a + ('F'..'Z').to_a + (0..9).to_a).shuffle[0,6].join
	return input.created_at.to_i.to_s.last(2) + (key + 'E' + input.id.to_s).last(8)
end

def decrypt (input, type)
	if input.length == 10
		d = [input.slice(0..1), input.slice(2..9)]
		pos = d[1].index('E') + 1
		id = d[1].slice(pos..7)
		if type==0
			p = Patient.find_by_id id
		elsif type==1
			p = Consultation.find_by_id id
		end

		if p.nil? || p.created_at.to_i.to_s.last(2) != d[0]
			return ''
		else
			return id
		end
	else
		return ''
	end
end
