class Authors < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = 'Author'
    c.data_store = { sorters: [:name] }
  end
end
