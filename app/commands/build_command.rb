class BuildCommand < ROM::SQL::Commands::Create
  # TODO: Don't register on specific relation - this command should be generic
  relation :projects
  register_as :build

  def execute(tuple)
    # TODO: Replace with equivalent of: `root.mapper.model.new(attributes)` from the repo
  end
end
