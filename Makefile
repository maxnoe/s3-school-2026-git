TEXOPTIONS=--lualatex --output-directory=build --halt-on-error --interaction=nonstopmode --shell-escape
TEXINPUTS=build:beamertheme-vertex:

all: build/git.pdf


build/git.pdf: FORCE
	TEXINPUTS=$(TEXINPUTS) latexmk $(TEXOPTIONS) git.tex

preview: FORCE
	TEXINPUTS=$(TEXINPUTS) latexmk $(TEXOPTIONS) -pvc git.tex

build/git.pdf: $(addprefix build/figures/, license.pdf github.png codeberg.pdf forgejo.pdf gitlab.png xkcd_git.png)


build/figures/github.png: | build/figures
	wget https://github-media-downloads.s3.amazonaws.com/GitHub-Logos.zip -O build/figures/GitHub-Logos.zip --no-use-server-timestamps
	cd build/figures && unzip GitHub-Logos.zip
	cp build/figures/GitHub-Logos/GitHub_Logo.png $@

build/figures/gitlab.png: | build/figures
	wget https://gitlab.com/gitlab-com/gitlab-artwork/raw/master/wordmark/wm_no_bg.png -O $@ --no-use-server-timestamps

build/figures/codeberg.pdf: | build/figures
	wget -O build/figures/codeberg.svg https://upload.wikimedia.org/wikipedia/commons/9/9a/Codeberg_logo.svg
	inkscape build/figures/codeberg.svg -o $@

build/figures/forgejo.pdf: | build/figures
	wget -O build/figures/forgejo.svg https://upload.wikimedia.org/wikipedia/commons/0/0f/Forgejo-wordmark.svg
	inkscape build/figures/forgejo.svg -o $@

build/figures/license.pdf: | build/figures
	wget -O build/figures/license.svg https://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by-nc-sa.svg
	inkscape build/figures/license.svg -o $@


build/figures/xkcd_git.png: | build/figures
	wget https://imgs.xkcd.com/comics/git_2x.png -O $@ --no-use-server-timestamps


build/figures:
	mkdir -p build/figures

clean:
	rm -rf build

FORCE:

.PHONY: all FORCE clean
