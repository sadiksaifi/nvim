return {
  "windwp/nvim-autopairs",
  config = function ()
    -- Using protected call
    local status_ok, autopairs = pcall(require, "nvim-autopairs")
    if not status_ok then
      return
    end
    autopairs.setup {}
  end
}
