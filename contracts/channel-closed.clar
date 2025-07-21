;; Channel Closed GUI: Creative Writing Challenge Platform
;; Contract: channel-closed
;;
;; A decentralized platform enabling creative writing challenges with transparent 
;; voting, fair rewards, and immutable content attribution.

;; Error codes
(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-CHALLENGE-MISSING (err u101))
(define-constant ERR-CHALLENGE-EXPIRED (err u102))
(define-constant ERR-CHALLENGE-ONGOING (err u103))
(define-constant ERR-SUBMISSION-MISSING (err u104))
(define-constant ERR-VOTING-CLOSED (err u105))
(define-constant ERR-DUPLICATE-VOTE (err u106))
(define-constant ERR-INSUFFICIENT-STAKE (err u107))
(define-constant ERR-INVALID-INPUT (err u108))
(define-constant ERR-SELF-INTERACTION (err u109))

;; Platform Constants
(define-constant PLATFORM-CREATION-FEE u1000000) ;; 1 STX
(define-constant MIN-CHALLENGE-DURATION u43200) ;; 12 hours
(define-constant MAX-CHALLENGE-DURATION u1051200) ;; 6 months
(define-constant PLATFORM-FEE-PERCENT u5) ;; 5% platform fee
(define-constant DEFAULT-SUBMISSION-FEE u100000) ;; 0.1 STX

;; Global Platform Variables
(define-data-var platform-admin principal tx-sender)
(define-data-var challenge-sequence uint u0)
(define-data-var submission-sequence uint u0)

;; Map Definitions
(define-map challenges
  uint ;; challenge-id
  {
    creator: principal,
    title: (string-ascii 100),
    description: (string-utf8 500),
    genre: (string-ascii 50),
    start-block: uint,
    end-block: uint,
    voting-end-block: uint,
    submission-fee: uint,
    total-stake: uint,
    total-rewards: uint,
    rewards-distributed: bool,
    submission-count: uint,
    vote-count: uint,
    status: (string-ascii 20)
  }
)

;; Similar data maps as in the original contract...
;; (The rest of the implementation would mirror the original)