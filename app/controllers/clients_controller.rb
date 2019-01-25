class ClientsController < ApplicationController
  skip_before_action :check_permissions
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :read_xml_rut_contacto

  # GET /clients
  # GET /clients.json
  def index
  client = UnabApi.new 
  rut = client.get_client_by_rut('15.540.874-k')
  created = client.get_ticket_created('2018-11-14')
  closed = client.get_ticket_closed('2018-11-14')
  managed = client.get_ticket_managed('2018-11-14')
  byebug
  @clients = Client.all.order(name: :asc)
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_url, notice: "Cliente '#{@client.name}' creado." }
        format.json { render :show, status: :created, location: @client }

        ClientInitialLoadJob.perform_later(@client, current_user)
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_url, notice: "Cliente '#{@client.name}' modificado." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    client = @client
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: "Cliente '#{client.name}' eliminado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :fb_ad_account_id, :ga_ad_account_id, :fb_dollar_conv, :main_color, :is_enabled)
    end

    def read_xml_rut_contacto
      xml_doc  = Nokogiri::XML("
        <OUTPUT>
        <SALIDA>
        <ESTADO>1</ESTADO>
        <DESCRIPCION_ESTADO>CORRECTO</DESCRIPCION_ESTADO>
        </SALIDA>
        <CONTACTO>
        <emailaddress1>abeolave@gmail.com</emailaddress1>
        <contactid>7fd9f827-50da-e711-80de-de8ad1a88d4a</contactid>
        <wa_rut>12976272-1</wa_rut>
        <da.mksv_estadoacademicoid>ACTIVO</da.mksv_estadoacademicoid>
        <da.mksv_programaid>MAG. EN INGENIERIA INDUSTRIAL</da.mksv_programaid>
        <fullname>ABELARDO ENRIQUE OLAVE AGUAYO</fullname>
        <da.mksv_campusid>Concepción</da.mksv_campusid>
        <prog.mksv_facultadid>Facultad de Ingeniería</prog.mksv_facultadid>
        </CONTACTO>
        <CONTACTO>
        <emailaddress1>abeolave@gmail.com</emailaddress1>
        <contactid>7fd9f827-50da-e711-80de-de8ad1a88d4a</contactid>
        <wa_rut>12976272-1</wa_rut>
        <da.mksv_estadoacademicoid>ACTIVO</da.mksv_estadoacademicoid>
        <da.mksv_programaid>MAG EN ING INDUST C Y SIN MENC</da.mksv_programaid>
        <fullname>ABELARDO ENRIQUE OLAVE AGUAYO</fullname>
        <da.mksv_campusid>Antonio Varas</da.mksv_campusid>
        <prog.mksv_facultadid>Facultad de Ingeniería</prog.mksv_facultadid>
        </CONTACTO>
        <CONTACTO>
        <emailaddress1>abeolave@gmail.com</emailaddress1>
        <contactid>7fd9f827-50da-e711-80de-de8ad1a88d4a</contactid>
        <wa_rut>12976272-1</wa_rut>
        <da.mksv_estadoacademicoid>ACTIVO</da.mksv_estadoacademicoid>
        <da.mksv_programaid>MAG. EN INGENIERIA INDUSTRIAL</da.mksv_programaid>
        <fullname>ABELARDO ENRIQUE OLAVE AGUAYO</fullname>
        <da.mksv_campusid>Antonio Varas</da.mksv_campusid>
        <prog.mksv_facultadid>Facultad de Ingeniería</prog.mksv_facultadid>
        </CONTACTO>
        <CONTACTO>
        <emailaddress1>abeolave@gmail.com</emailaddress1>
        <contactid>7fd9f827-50da-e711-80de-de8ad1a88d4a</contactid>
        <wa_rut>12976272-1</wa_rut>
        <da.mksv_estadoacademicoid>EGRESO</da.mksv_estadoacademicoid>
        <da.mksv_programaid>ING EN LOGÍSTICA Y TRANSP</da.mksv_programaid>
        <fullname>ABELARDO ENRIQUE OLAVE AGUAYO</fullname>
        <da.mksv_campusid>República</da.mksv_campusid>
        <prog.mksv_facultadid>Facultad de Ingeniería</prog.mksv_facultadid>
        </CONTACTO>
        </OUTPUT>")
        @block = xml_doc.xpath("//SALIDA/ESTADO")
        @block = xml_doc.xpath("//SALIDA/DESCRIPCION_ESTADO")
        @block = xml_doc.xpath("//CONTACTO").each do |contact|
          contact.xpath("emailaddress1")
          contact.xpath("contactid")
          contact.xpath("wa_rut")
          contact.xpath("fullname")
          contact.xpath("emailaddress1")
          contact.xpath("da.mksv_estadoacademicoid")
          contact.xpath("da.mksv_programaid")
          contact.xpath("da.mksv_campusid")
          contact.xpath("prog.mksv_facultadid")
        end
        @block = xml_doc.xpath("//CONTACTO") 
    end

    def read_xml_get_ticket
      xml_doc  = Nokogiri::XML("<OUTPUT>
        <SALIDA>
        <ESTADO>1</ESTADO>
        <DESCRIPCION_ESTADO>CORRECTO</DESCRIPCION_ESTADO>
        </SALIDA>
        <CASOS_CREADOS>
        <statecode>1</statecode>
        <casetypecode>1</casetypecode>
        <createdon>14-11-2018 21:23:23</createdon>
        <mksv_unidaddenegociodelpropietarioid>Call Center</mksv_unidaddenegociodelpropietarioid>
        <ticketnumber>C-00798-Y9L9</ticketnumber>
        <ownerid>contact 16</ownerid>
        <modifiedon>14-11-2018 21:23:59</modifiedon>
        <ctc.telephone2>56 221111111</ctc.telephone2>
        <mksv_campusid>República</mksv_campusid>
        <prioritycode>2</prioritycode>
        <mksv_carreraid>ING. CIVIL INDUSTRIAL E10</mksv_carreraid>
        <prog.mksv_facultadid>Facultad de Ingeniería</prog.mksv_facultadid>
        <ctc.emailaddress1>nelson.o.morales@hotmail.com</ctc.emailaddress1>
        <statuscode>1000</statuscode>
        <modifiedby>ADMINISTRADOR MS DYNAMICS CRM</modifiedby>
        <mksv_unidaddenegociodelautorid>Call Center</mksv_unidaddenegociodelautorid>
        <mksv_fasedelcaso>3</mksv_fasedelcaso>
        <subjectid>2.1.11.04 Entrega Diploma</subjectid>
        <mksv_canaldeingresoid>Call Center</mksv_canaldeingresoid>
        <ctc.wa_rut>16939595-0</ctc.wa_rut>
        <ownr.businessunitid>Call Center</ownr.businessunitid>
        <createdby>contact 16</createdby>
        <mksv_cierreenprimeralinea>True</mksv_cierreenprimeralinea>
        <customerid>NELSON GABRIEL ORMEÑO MORALES</customerid>
        <incidentid>8244bd83-53e8-e811-80fe-0050569999b3</incidentid>
        <ctc.mobilephone>56 963414213</ctc.mobilephone>
        <statecodename>Resuelto</statecodename>
        <casetypecodename>Consulta</casetypecodename>
        <createdonname>14-11-2018 18:23</createdonname>
        <modifiedonname>14-11-2018 18:23</modifiedonname>
        <prioritycodename>Normal</prioritycodename>
        <statuscodename>Información proporcionada</statuscodename>
        <mksv_fasedelcasoname>Cerrar</mksv_fasedelcasoname>
        <mksv_cierreenprimeralineaname>Sí</mksv_cierreenprimeralineaname>
        </CASOS_CREADOS>
        <CASOS_CREADOS>...</CASOS_CREADOS>
        <CASOS_CREADOS>...</CASOS_CREADOS>
        </OUTPUT>")
        @block = xml_doc.xpath("//CASOS_CREADOS")
        @block = xml_doc.xpath("//CASOS_CREADOS").each do |field|
          field.xpath("statecode")
          field.xpath("casetypecode")
          field.xpath("createdon")
          field.xpath("mksv_unidaddenegociodelpropietarioid")
          field.xpath("ticketnumber")
          field.xpath("ownerid")
          field.xpath("modifiedon")
          field.xpath("ctc.telephone2")
          field.xpath("mksv_campusid")
          field.xpath("prioritycode")
          field.xpath("mksv_carreraid")
          field.xpath("prog.mksv_facultadid")
          field.xpath("ctc.emailaddress1")
          field.xpath("statuscode")
          field.xpath("modifiedby")
          field.xpath("mksv_unidaddenegociodelautorid")
          field.xpath("mksv_fasedelcaso")
          field.xpath("subjectid")
          field.xpath("mksv_canaldeingresoid")
          field.xpath("ctc.wa_rut")
          field.xpath("ownr.businessunitid")
          field.xpath("createdby")
          field.xpath("mksv_cierreenprimeralinea")
          field.xpath("customerid")
          field.xpath("incidentid")
          field.xpath("ctc.mobilephone")
          field.xpath("statecodename")
          field.xpath("casetypecodename")
          field.xpath("createdonname")
          field.xpath("modifiedonname")
          field.xpath("prioritycodename")
          field.xpath("statuscodename")
          field.xpath("mksv_fasedelcasoname")
          field.xpath("mksv_cierreenprimeralineaname")
        end
        xml_doc
    end

    def read_xml_get_managed_ticket
      xml_doc = "<OUTPUT>
      <SALIDA>
      <ESTADO>1</ESTADO>
      <DESCRIPCION_ESTADO>CORRECTO</DESCRIPCION_ESTADO>
      </SALIDA>
      <CASOS_GESTIONADOS>
      <statecode>0</statecode>
      <casetypecode>2</casetypecode>
      <createdon>14-11-2018 20:20:26</createdon>
      <mksv_unidaddenegociodelpropietarioid>DMGF</mksv_unidaddenegociodelpropietarioid>
      <ticketnumber>C-00794-L4N2</ticketnumber>
      <ownerid>Equipo DMGF Bellavista</ownerid>
      <modifiedon>14-11-2018 20:22:40</modifiedon>
      <ctc.telephone2>56 228147045</ctc.telephone2>
      <mksv_campusid>Bellavista</mksv_campusid>
      <prioritycode>2</prioritycode>
      <mksv_carreraid>DERECHO</mksv_carreraid>
      <prog.mksv_facultadid>Facultad de Derecho</prog.mksv_facultadid>
      <ctc.emailaddress1>elmusicodechile@gmail.com</ctc.emailaddress1>
      <statuscode>1</statuscode>
      <modifiedby>contact 16</modifiedby>
      <mksv_unidaddenegociodelautorid>Call Center</mksv_unidaddenegociodelautorid>
      <mksv_fasedelcaso>4</mksv_fasedelcaso>
      <subjectid>3.3.11.01 Acreditación</subjectid>
      <mksv_canaldeingresoid>Call Center</mksv_canaldeingresoid>
      <ctc.wa_rut>15540874-K</ctc.wa_rut>
      <createdby>contact 16</createdby>
      <mksv_cierreenprimeralinea>False</mksv_cierreenprimeralinea>
      <customerid>HECTOR ANTONIO FIERRO CONTRERAS</customerid>
      <incidentid>f39a95b8-4ae8-e811-80fe-0050569999b3</incidentid>
      <ctc.mobilephone>56 961189574</ctc.mobilephone>
      <statecodename>Activo</statecodename>
      <casetypecodename>Reclamo</casetypecodename>
      <createdonname>14-11-2018 17:20</createdonname>
      <modifiedonname>14-11-2018 17:22</modifiedonname>
      <prioritycodename>Normal</prioritycodename>
      <statuscodename>En curso</statuscodename>
      <mksv_fasedelcasoname>Tipificación</mksv_fasedelcasoname>
      <mksv_cierreenprimeralineaname>No</mksv_cierreenprimeralineaname>
      </CASOS_GESTIONADOS>
      <CASOS_GESTIONADOS>...</CASOS_GESTIONADOS>
      </OUTPUT>"
      xml_doc

    end


  end
