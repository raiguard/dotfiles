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
  _BASE,
  _HMMODS,
  _GAME,
  _MSE,
  _NUM,
  _NAV
};

#define LCTL_ESC MT(MOD_LCTL, KC_ESC)
#define HMMODS TG(_HMMODS)
#define NUM MO(_NUM)
#define MSE TG(_MSE)
#define GAME TG(_GAME)
#define NAV MO(_NAV)

const uint16_t PROGMEM toggle_mouse[] = {KC_SPC, NUM, COMBO_END};
const uint16_t PROGMEM toggle_game[] = {KC_LALT, NAV, COMBO_END};
combo_t key_combos[COMBO_COUNT] = {
    COMBO(toggle_mouse, MSE),
    COMBO(toggle_game, GAME)
};

// Homerow mods - MAIN
#define LGUI_A LGUI_T(KC_A)
#define LALT_S LALT_T(KC_S)
#define LCTL_D LCTL_T(KC_D)
#define LSFT_F LSFT_T(KC_F)
#define RSFT_J RSFT_T(KC_J)
#define RCTL_K RCTL_T(KC_K)
#define RALT_L RALT_T(KC_L)
#define RGUI_SCLN RGUI_T(KC_SCLN)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  [_BASE] = LAYOUT_ortho_4x12(
    KC_TAB,   KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,   KC_Y, KC_U, KC_I,    KC_O,    KC_P,    KC_BSPC,
    LCTL_ESC, KC_A,    KC_S,    KC_D,    KC_F,    KC_G,   KC_H, KC_J, KC_K,    KC_L,    KC_SCLN, KC_QUOT,
    KC_LSFT,  KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,   KC_N, KC_M, KC_COMM, KC_DOT,  KC_SLSH, KC_ENT,
    _______,  _______, _______, KC_LGUI, KC_LALT, KC_SPC, NUM,  NAV,  _______, _______, _______, HMMODS
  ),

  [_HMMODS] = LAYOUT_ortho_4x12(
    _______, KC_Q,    KC_W,    KC_E,    KC_R,   KC_T,   KC_Y, KC_U,   KC_I,    KC_O,    KC_P,      KC_BSPC,
    KC_ESC,  LGUI_A,  LALT_S,  LCTL_D,  LSFT_F, KC_G,   KC_H, RSFT_J, RCTL_K,  RALT_L,  RGUI_SCLN, KC_QUOT,
    XXXXXXX, KC_Z,    KC_X,    KC_C,    KC_V,   KC_B,   KC_N, KC_M,   KC_COMM, KC_DOT,  KC_SLSH,   KC_ENT,
    _______, _______, _______, _______, KC_TAB, KC_SPC, NUM,  NAV,    _______, _______, _______,   _______
  ),

  // Shift thumb bar over by one for use with WASD
  [_GAME] = LAYOUT_ortho_4x12(
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,
    _______, _______, KC_LGUI, KC_LALT, KC_SPC,  NUM,     _______, _______, _______, _______, _______, _______
  ),

  // Mouse controls
  // Also have a way to access NAV in case we're gaming
  [_MSE] = LAYOUT_ortho_4x12(
    _______, _______, _______, _______, _______, _______, KC_WH_L, KC_WH_D, KC_WH_U, KC_WH_R, _______, _______,
    _______, _______, _______, _______, _______, _______, KC_MS_L, KC_MS_D, KC_MS_U, KC_MS_R, KC_ACL2, _______,
    _______, _______, _______, _______, _______, _______, NUM,     KC_BTN3, _______, _______, _______, _______,
    _______, _______, _______, _______, _______, _______, KC_BTN1, KC_BTN2, _______, _______, _______, _______
  ),

  // Numbers and symbols, optimized for the most common symbols across all programming languages
  [_NUM] = LAYOUT_ortho_4x12(
    KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
    _______, KC_DLR,  KC_PLUS, KC_LPRN, KC_RPRN, KC_AT,   KC_PIPE, KC_MINS, KC_EQL,  KC_UNDS, KC_ASTR, KC_BSLS,
    _______, KC_EXLM, KC_HASH, KC_LCBR, KC_RCBR, KC_TILD, KC_AMPR, KC_LBRC, KC_RBRC, KC_PERC, KC_CIRC, _______,
    _______, _______, _______, _______, _______, _______, NAV,     _______, _______, _______, _______, _______
  ),

  // Function and arrow keys, plus media controls
  [_NAV] = LAYOUT_ortho_4x12(
    RGB_TOG, KC_F1,   KC_F2,   KC_F3,   KC_F4,   _______, KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT,  KC_MPLY, KC_PSCR,
    _______, KC_F5,   KC_F6,   KC_F7,   KC_F8,   _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, _______, KC_DEL,
    _______, KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END,   _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,  _______, RESET
  ),

};
