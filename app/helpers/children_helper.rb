module ChildrenHelper

	def goals_progress_summary (entries, areas)

		learning_areas = EntryLearningArea.where(:entry_id => entries.map { |entry| entry.id })

		area_counts = learning_areas.group(:learning_area_id).count
		max_count = area_counts.values.max

		puts area_counts.to_yaml
		puts max_count.to_yaml

		content_tag(:table, class: "goal-summary") do

			areas.collect do |area|
				content_tag(:tr) do
					content_tag(:td) do
						content_tag(:a, href: "#", tooltip: area.name) do
							tag(:img, src: '/assets/social-icon.png', class: 'goal-icon')
						end
					end +
					

					content_tag(:td) do
						content_tag(:span, area_counts[area.id], class: "progress", style: "width: #{area_counts[area.id].to_f / max_count * 100}%")
					end
				end
			end.join.html_safe
		end
	end

end