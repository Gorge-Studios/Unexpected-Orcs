package com.bmd.game.GUI;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Screen;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.InputEvent;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.scenes.scene2d.ui.Image;
import com.badlogic.gdx.scenes.scene2d.ui.ImageButton;
import com.badlogic.gdx.scenes.scene2d.ui.Skin;
import com.badlogic.gdx.scenes.scene2d.utils.ClickListener;
import com.badlogic.gdx.scenes.scene2d.utils.SpriteDrawable;
import com.bmd.game.Sprites.Sprites;
import com.bmd.game.Tiles.Tiles;
import com.bmd.game.UnexpectedOrcs;
import com.bmd.game.Util.Util;

public class NewGameMenu implements Screen {

    private UnexpectedOrcs game;
    private Stage stage;

    private Sprite background = new Sprite(new Texture("./sprites/title.png"));

    private ImageButton play  = new ImageButton(new SpriteDrawable(Sprites.guiSprite("PLAY", Tiles.TILE_SIZE * 2, Tiles.TILE_SIZE)));
    private ImageButton back  = new ImageButton(new SpriteDrawable(Sprites.guiSprite("BACK", Tiles.TILE_SIZE * 2, Tiles.TILE_SIZE)));

    public NewGameMenu(UnexpectedOrcs g) {
        game = g;

        stage = new Stage();
        Gdx.input.setInputProcessor(stage);

        Skin skin = new Skin();

        play.setPosition(Util.width/2 - Tiles.TILE_SIZE, Util.height/2 + Tiles.TILE_SIZE);
        play.setSize(Tiles.TILE_SIZE * 2, Tiles.TILE_SIZE);
        play.addListener(new ClickListener() {
            @Override public void touchUp(InputEvent e, float x, float y, int p, int b) { playClicked(); }
        });

        back.setPosition(Util.width/2 - Tiles.TILE_SIZE, Util.height/2 - Tiles.TILE_SIZE * 3);
        back.setSize(Tiles.TILE_SIZE * 2, Tiles.TILE_SIZE);
        back.addListener(new ClickListener() {
            @Override public void touchUp(InputEvent e, float x, float y, int p, int b) { backClicked(); }
        });

        stage.addActor(new Image(new SpriteDrawable(background)));
        stage.addActor(play);
        stage.addActor(back);
    }

    private void playClicked() {
        game.setState(States.PLAYING);
    }

    private void backClicked() {
        game.revertState();
    }

    @Override
    public void show() {

    }

    @Override
    public void render(float delta) {
        Gdx.gl.glClearColor(0, 0, 0, 0);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

        stage.act(delta);
        stage.draw();
    }

    @Override
    public void resize(int width, int height) {

    }

    @Override
    public void pause() {

    }

    @Override
    public void resume() {

    }

    @Override
    public void hide() {

    }

    @Override
    public void dispose() {
        stage.dispose();
    }
}
