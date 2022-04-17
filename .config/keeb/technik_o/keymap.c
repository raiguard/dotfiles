/* Copyright 2020 Boardsource
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

enum layers {
  MAIN,
  NUM,
  NAV,
  SYM,
  GAME,
  MOUSE,
};

// Layer toggles
#define NUM_TAB LT(NUM, KC_BSPC)
#define NAV_RETN LT(NAV, KC_RETN)
#define SYM_BSPC LT(SYM, KC_TAB)

// Homerow mods - MAIN
#define LGUI_A LGUI_T(KC_A)
#define LALT_S LALT_T(KC_S)
#define LCTL_D LCTL_T(KC_D)
#define LSFT_F LSFT_T(KC_F)
#define RSFT_J RSFT_T(KC_J)
#define RCTL_K RCTL_T(KC_K)
#define RALT_L RALT_T(KC_L)
#define RGUI_QUOT RGUI_T(KC_QUOT)

// Homerow mods - NUM

#define LGUI_F5 LGUI_T(KC_F5)
#define LALT_F6 LALT_T(KC_F6)
#define LCTL_F7 LCTL_T(KC_F7)
#define LSFT_F8 LSFT_T(KC_F8)
#define RSFT_4 RSFT_T(KC_4)
#define RCTL_5 RCTL_T(KC_5)
#define RALT_6 RALT_T(KC_6)

// Homerow mods - SYM
#define LGUI_LT LGUI_T(KC_LT)
#define LALT_LCBR LALT_T(KC_LCBR)
#define LCTL_LBRC LCTL_T(KC_LBRC)
#define LSFT_LPRN LSFT_T(KC_LPRN)
#define RSFT_RPRN RSFT_T(KC_RPRN)
#define RCTL_RBRC RCTL_T(KC_RBRC)
#define RALT_RCBR RALT_T(KC_RCBR)
#define RGUI_GT RGUI_T(KC_GT)

// Combos
const uint16_t PROGMEM toggle_game[] = {KC_TAB, KC_BSPC, COMBO_END};
const uint16_t PROGMEM toggle_mouse[] = {KC_SPC, KC_RETN, COMBO_END};
combo_t key_combos[COMBO_COUNT] = {
    COMBO(toggle_game, TG(GAME)),
    COMBO(toggle_mouse, TG(MOUSE)),
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [MAIN] = LAYOUT_ortho_4x12(
    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,   _______, _______, KC_Y,     KC_U,     KC_I,    KC_O,    KC_P,
    LGUI_A,  LALT_S,  LCTL_D,  LSFT_F,  KC_G,   _______, _______, KC_H,     RSFT_J,   RCTL_K,  RALT_L,  RGUI_QUOT,
    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,   _______, _______, KC_N,     KC_M,     KC_COMM, KC_DOT,  KC_SLSH,
    _______, _______, _______, NUM_TAB, KC_SPC, _______, _______, NAV_RETN, SYM_BSPC, _______, _______, _______
  ),

  [NUM] = LAYOUT_ortho_4x12(
    KC_F1,   KC_F2,   KC_F3,   KC_F4,   _______, _______, _______, _______, KC_7,    KC_8,    KC_9,    _______,
    LGUI_F5, LALT_F6, LCTL_F7, LSFT_F8, _______, _______, _______, _______, RSFT_4,  RCTL_5,  RALT_6,  KC_RCTL,
    KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______, _______, _______, KC_0,    KC_1,    KC_2,    KC_3,    KC_DOT,
    _______, _______, _______, _______, KC_SPC,  _______, _______, KC_RETN, KC_BSPC, _______, _______, _______
  ),

  [NAV] = LAYOUT_ortho_4x12(
    RESET,   _______, _______, _______, KC_PSCR, _______, _______, KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT,  _______,
    KC_LGUI, KC_LALT, KC_LCTL, KC_LSFT, _______, _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, _______,
    _______, _______, _______, _______, _______, _______, _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END,   _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,  _______
  ),

  [SYM] = LAYOUT_ortho_4x12(
    KC_EXLM, KC_AT,     KC_HASH,   KC_DLR,    KC_PERC, _______, _______, KC_CIRC, KC_AMPR,   KC_ASTR,   KC_EQL,    KC_QUES,
    LGUI_LT, LALT_LCBR, LCTL_LBRC, LSFT_LPRN, KC_UNDS, _______, _______, KC_MINS, RSFT_RPRN, RCTL_RBRC, RALT_RCBR, RGUI_GT,
    KC_BSLS, KC_GRAVE,  KC_SCLN,   KC_COLN,   KC_UNDS, _______, _______, KC_TILD, KC_PIPE,   KC_DQT,    KC_QUOT,   KC_SLSH,
    _______, _______,   _______,   KC_TAB,    KC_SPC,  _______, _______, KC_RETN, _______,   _______,   _______,   _______
  ),

  [GAME] = LAYOUT_ortho_4x12(
    KC_ESC,  KC_Q,    KC_W,    KC_E,    KC_R,   _______, _______, KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,
    KC_LSFT, KC_A,    KC_S,    KC_D,    KC_F,   _______, _______, KC_G,    KC_H,    KC_J,    KC_K,    KC_L,
    KC_LCTL, KC_Z,    KC_X,    KC_C,    KC_V,   _______, _______, KC_B,    KC_N,    KC_M,    KC_P,    KC_LALT,
    _______, _______, _______, NUM_TAB, KC_SPC, _______, _______, KC_RETN, KC_BSPC, _______, _______, _______
  ),

  [MOUSE] = LAYOUT_ortho_4x12(
    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, _______, _______, KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, KC_ACL2,
    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, _______, _______, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_ACL1,
    KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, _______, _______, _______, KC_BTN3, _______, _______, KC_TRNS,
    _______, _______, _______, KC_TRNS, KC_TRNS, _______, _______, KC_BTN1, KC_BTN2, _______, _______, _______
  ),
};

