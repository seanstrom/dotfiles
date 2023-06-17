src-path := src
dist-path := dist
target-output := wezterm.lua
fennel-compiler := fennel
fennel-flags := \
	--add-fennel-path 'src/?.fnl' \
	--add-macro-path 'src/?.fnl'

all: build link 

link: $(target-output)
	@ln -sf $(dist-path)/$(target-output) $(target-output)
	@echo "Linked $(target-output)"

build: $(target-output)

clean:
	@rm -rf $(dist-path)/*
	@rm -f $(target-output)
	@echo "Cleaned"

%.lua: $(src-path)/%.fnl
	@echo "Compiling $<"
	@$(fennel-compiler) $(fennel-flags) -c $< > $(dist-path)/$@
	@echo "Built $(dist-path)/$(target-output)"
