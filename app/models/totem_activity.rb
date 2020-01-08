class TotemActivity < ApplicationRecord
  belongs_to :person

  def self.get_activities_from_crm(from_date, to_date)
    unab_api = UnabApi.new
    check = StringUtils.new
    from_date = from_date.to_datetime
    to_date = to_date.to_datetime
    from_date.upto(to_date) do |date|
      #date = date.strftime("%Y-%m-%d")
      activities = unab_api.get_contacts_created(date)
      if activities[:salida][:estado].include?("1")
        if activities[:actividad_totem].class == Array
          TotemActivity.transaction do
            activities[:actividad_totem].each do |activity|
              person = Person.find_by(rut: check.normalize_rut(activity[:ctc_wa_rut]))
              if person.present?
                totem_attention                      = person.totem_activities.find_or_initialize_by(crm_totem_activity_id: activities[:actividad_totem][:mksv_actividadtotemid])
                totem_attention.name                 = activity[:mksv_contactoid]
                totem_attention.attention_time_start = activity[:mksv_fechainicioatencionname]
                totem_attention.attetion_time_end    = activity[:mksv_fechafinatencionname]
                totem_attention.rut                  = activity[:ctc_wa_rut]
                totem_attention.executive_name       = activity[:mksv_ejecutivodeatencionid]
                totem_attention.broadcast_time       = activity[:mksv_fechadeemisionname]
                totem_attention.description          = activity[:mksv_descripcion]
                totem_attention.row_letter           = activity[:mksv_letradelafila]
                totem_attention.branch_office        = activity[:mksv_sucursalid]
                totem_attention.attention_number     = activity[:mksv_ndeatencion]
                totem_attention.state                = activity[:statecodename]
                totem_attention.status               = activity[:statuscodename]
                totem_attention.save
              end
            end
          end
        else
          person = Person.find_by(rut: check.normalize_rut(activity[:ctc_wa_rut]))
          if person.present?
            totem_attention                      = person.totem_activities.find_or_initialize_by(crm_totem_activity_id: activities[:actividad_totem][:mksv_actividadtotemid])
            totem_attention.name                 = activities[:actividad_totem][:mksv_contactoid]
            totem_attention.attention_time_start = activities[:actividad_totem][:mksv_fechainicioatencionname]
            totem_attention.attetion_time_end    = activities[:actividad_totem][:mksv_fechafinatencionname]
            totem_attention.rut                  = activities[:actividad_totem][:ctc_wa_rut]
            totem_attention.executive_name       = activities[:actividad_totem][:mksv_ejecutivodeatencionid]
            totem_attention.broadcast_time       = activities[:actividad_totem][:mksv_fechadeemisionname]
            totem_attention.description          = activities[:actividad_totem][:mksv_descripcion]
            totem_attention.row_letter           = activities[:actividad_totem][:mksv_letradelafila]
            totem_attention.branch_office        = activities[:actividad_totem][:mksv_sucursalid]
            totem_attention.attention_number     = activities[:actividad_totem][:mksv_ndeatencion]
            totem_attention.state                = activities[:actividad_totem][:statecodename]
            totem_attention.status               = activities[:actividad_totem][:statuscodename]
            totem_attention.save
          end
        end
      end
    end
  end

end
