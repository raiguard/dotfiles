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
  _NUM,
  _SYM,
  _NAV
};

#define LCTL_ESC MT(MOD_LCTL, KC_ESC)
#define SYM_ENT LT(SYM, KC_ENT)
#define NUM_SPC LT(NUM, KC_SPC)
#define NUM MO(_NUM)
#define SYM MO(_SYM)
#define MSE TG(_MSE)
#define NAV MO(_NAV)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  // Two dedicated space keys, one for regular use and another for gaming on WASD
  [_BASE] = LAYOUT_ortho_4x12(
    KC_TAB,   KC_Q,    KC_W,    KC_E,    KC_R,   KC_T,    KC_Y,    KC_U, KC_I,    KC_O,    KC_P,    KC_BSPC,
    LCTL_ESC, KC_A,    KC_S,    KC_D,    KC_F,   KC_G,    KC_H,    KC_J, KC_K,    KC_L,    KC_SCLN, KC_QUOT,
    KC_LSFT,  KC_Z,    KC_X,    KC_C,    KC_V,   KC_B,    KC_N,    KC_M, KC_COMM, KC_DOT,  KC_SLSH, KC_RSFT,
    _______,  _______, _______, KC_LALT, KC_SPC, NUM_SPC, SYM_ENT, NAV,  KC_LGUI, _______, _______, _______
  ),

  [_NUM] = LAYOUT_ortho_4x12(
    _______, _______, KC_7,    KC_8,    KC_9,    KC_MINS, _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,   _______,
    _______, _______, KC_4,    KC_5,    KC_6,    KC_0,    _______, KC_F5,   KC_F6,   KC_F7,   KC_F8,   _______,
    _______, _______, KC_1,    KC_2,    KC_3,    KC_DOT,  _______, KC_F9,   KC_F10,  KC_F11,  KC_F12,  _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______
  ),

  [_SYM] = LAYOUT_ortho_4x12(
    _______, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC, KC_CIRC, KC_AMPR, KC_ASTR, KC_EQL,  KC_QUES, _______,
    _______, KC_LABK, KC_LCBR, KC_LBRC, KC_LPRN, KC_MINS, KC_PLUS, KC_RPRN, KC_RBRC, KC_RCBR, KC_RABK, _______,
    _______, KC_SLSH, KC_GRV,  KC_DQUO, KC_QUOT, KC_UNDS, KC_TILD, KC_PIPE, KC_SCLN, KC_COLN, KC_BSLS, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______

  ),

  [_NAV] = LAYOUT_ortho_4x12(
    _______, KC_PSCR, KC_VOLD, KC_MUTE, KC_VOLU, KC_BRIU, _______, _______, _______, _______,  _______, KC_DEL,
    _______, _______, KC_MPRV, KC_MPLY, KC_MNXT, KC_BRID, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, _______, KC_INS,
    _______, _______, _______, _______, _______, _______, KC_HOME, KC_PGDN, KC_PGUP, KC_END,   _______, _______,
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,  _______, RESET
  )

};
