	.include "asm/macros.inc"
	.include "global.inc"
	
.public LoadAlloc_FromHead
.public LoadAlloc_FromTail
.public LoadAlloc_Snd

.public PreLoad_SoundArchiveZone
.public PreLoad_SoundArchiveBoss

.public PostLoad_InitRawArchive
.public PostLoad_InitMapArchive
.public PostLoad_InitEveArchive
.public PostLoad_InitMapFar
.public PostLoad_InitPlayerArchive
.public PostLoad_InitCommonArchive
.public PostLoad_InitStageArchive
.public PostLoad_InitSoundArchive
.public PostLoad_InitBossAssetsZ1
.public PostLoad_InitBossAssetsZ2
.public PostLoad_InitBossAssetsZ3
.public PostLoad_InitBossAssetsZ4
.public PostLoad_InitBossAssetsZ5
.public PostLoad_InitBossAssetsZ6
.public PostLoad_InitBossAssetsZ7
.public PostLoad_InitBossAssetsZF

	.rodata

.public assetList_Common
assetList_Common:
        .word assetList_CommonAct
        .word 2

        .word assetList_CommonBoss
        .word 2

.public assetList_CommonBoss
assetList_CommonBoss:
        .word aNarcPlayerLz7N
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitPlayerArchive

        .word aNarcActComBLz7
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitCommonArchive

.public assetList_CommonAct
assetList_CommonAct:
        .word aNarcPlayerLz7N
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitPlayerArchive

        .word aNarcActComLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitCommonArchive

.public assetList_Z93
assetList_Z93:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ93MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ93EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z11
assetList_Z11:
        .word aNarcZ11ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ11RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ11MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ11EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ11Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ11SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z62
assetList_Z62:
        .word aNarcZ61ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ62RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ62MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ62EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ61Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ62SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z12
assetList_Z12:
        .word aNarcZ11ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ12RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ12MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ12EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ12Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ12SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z94
assetList_Z94:
        .word aNarcZ31ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ31RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ33MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ33EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ31Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ31SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z914
assetList_Z914:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm9MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm9EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_VS3
assetList_VS3:
        .word aNarcZ31ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ31RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZv3MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZv3EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ31Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ31SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z95
assetList_Z95:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ94MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ94EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z21
assetList_Z21:
        .word aNarcZ21ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ21RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ21MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ21EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ21Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ21SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z22
assetList_Z22:
        .word aNarcZ21ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ22RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ22MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ22EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ21Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ22SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z96
assetList_Z96:
        .word aNarcZ11ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ11RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm1MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm1EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ12Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ11SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z915
assetList_Z915:
        .word aNarcZ41ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ41RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm10MapNar
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm10EveNar
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ41Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ41SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z71
assetList_Z71:
        .word aNarcZ71ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ71RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ71MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ71EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ71Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ71SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z97
assetList_Z97:
        .word aNarcZ11ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ11RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm2MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm2EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ12Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ11SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z72
assetList_Z72:
        .word aNarcZ71ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ72RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ72MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ72EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ71Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ72SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_VS4
assetList_VS4:
        .word aNarcZ41ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ41RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZv4MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZv4EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ41Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ41SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z31
assetList_Z31:
        .word aNarcZ31ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ31RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ31MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ31EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ31Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ31SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z32
assetList_Z32:
        .word aNarcZ31ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ32RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ32MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ32EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ31Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ32SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z98
assetList_Z98:
        .word aNarcZ31ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ31RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm3MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm3EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ31Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ31SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z916
assetList_Z916:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm11MapNar
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm11EveNar
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_R2
assetList_R2:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZr2MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZr2EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_R3
assetList_R3:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZr3MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZr3EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z99
assetList_Z99:
        .word aNarcZ21ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ21RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm4MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm4EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ21Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ21SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z41
assetList_Z41:
        .word aNarcZ41ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ41RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ41MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ41EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ41Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ41SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive


.public assetList_Z42
assetList_Z42:
        .word aNarcZ41ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ42RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ42MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ42EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ41Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ42SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z910
assetList_Z910:
        .word aNarcZ21ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ21RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm5MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm5EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ21Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ21SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_VS1
assetList_VS1:
        .word aNarcZ11ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ11RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZv1MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZv1EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ12Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ11SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z911
assetList_Z911:
        .word aNarcZ31ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ31RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm6MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm6EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ31Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ31SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z51
assetList_Z51:
        .word aNarcZ51ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ51RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ51MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ51EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ51Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ51SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z1T
assetList_Z1T:
        .word aNarcZ1tActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ11RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ1tMapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ1tEveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ11Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ1tSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_R1
assetList_R1:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZr1MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZr1EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z52
assetList_Z52:
        .word aNarcZ52ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ52RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ52MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ52EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ51Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ52SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z912
assetList_Z912:
        .word aNarcZ51ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ51RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm7MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm7EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ51Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ51SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_VS2
assetList_VS2:
        .word aNarcZ21ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ21RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZv2MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZv2EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ21Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ21SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z91
assetList_Z91:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ91MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ91EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z913
assetList_Z913:
        .word aNarcZ51ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ51RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZm8MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZm8EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ51Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ51SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z92
assetList_Z92:
        .word aNarcZ91ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ91RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ92MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ92EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ91Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ91SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z61
assetList_Z61:
        .word aNarcZ61ActLz7N
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ61RawNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ61MapNarc
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ61EveNarc
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ61Bbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ61SoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveZone
        .word PostLoad_InitSoundArchive

.public assetList_Z1B
assetList_Z1B:
        .word aNarcZ1bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ1bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ1bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ1bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ1bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ1bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss1BodyLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ1

        .word aModBoss1StageL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ1


.public assetList_Z7B
assetList_Z7B:
        .word aNarcZ7bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ7bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ7bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ7bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ7bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ7bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss7BodyLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ7

        .word aModBoss7StageL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ7


.public assetList_ZFB
assetList_ZFB:
        .word aNarcZ8bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ8bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ8bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ8bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ8bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZfbSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBossfBodyLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZF

        .word aModBossfArmLLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZF

        .word aModBossfArmRLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZF


.public assetList_Z4B
assetList_Z4B:
        .word aNarcZ4bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ4bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ4bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ4bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ4bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ4bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss4BodyLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ4

        .word aModBoss4CoreLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ4

        .word aModBoss4StageL
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ4


.public assetList_Z6B
assetList_Z6B:
        .word aNarcZ6bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ6bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ6bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ6bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ6bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ6bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss6BodyLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ6

        .word aModBoss6ZakoLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ6

        .word aModBoss6StageL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ6

        .word aModBoss6SkyLz7
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ6


.public assetList_Z5B
assetList_Z5B:
        .word aNarcZ5bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ5bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ5bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ5bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ5bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ5bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss5BodyLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ5

        .word aModBoss5CoreLz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ5

        .word aModBoss5StageL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ5

        .word aModBoss5MapALz
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitBossAssetsZ5


.public assetList_Z3B
assetList_Z3B:
        .word aNarcZ3bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ3bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ3bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ3bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ3bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ3bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss3BodyLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ3

        .word aModBoss3Stage0
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ3

        .word aModBoss3Stage0_0
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ3

        .word aModBoss3Stage0_1
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ3

        .word aModBoss3Stage0_2
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ3
	
.public flushAreaTable
flushAreaTable: // 0x0210D9B8
	.word gmGameData__FlushZ11, gmGameData__FlushZ12
	.word gmGameData__FlushZ11, gmGameData__FlushZ1B
	.word gmGameData__FlushZ21, gmGameData__FlushZ22
	.word gmGameData__FlushZ2B, gmGameData__FlushZ31
	.word gmGameData__FlushZ32, gmGameData__FlushZ91
	.word gmGameData__FlushZ3B, gmGameData__FlushZ41
	.word gmGameData__FlushZ42, gmGameData__FlushZ4B
	.word gmGameData__FlushZ51, gmGameData__FlushZ52
	.word gmGameData__FlushZ5B, gmGameData__FlushZ61
	.word gmGameData__FlushZ62, gmGameData__FlushZ91
	.word gmGameData__FlushZ6B, gmGameData__FlushZ71
	.word gmGameData__FlushZ72, gmGameData__FlushZ7B
	.word gmGameData__FlushZFB, gmGameData__FlushZ91
	.word gmGameData__FlushZ31, gmGameData__FlushZ91
	.word gmGameData__FlushZ11, gmGameData__FlushZ11
	.word gmGameData__FlushZ31, gmGameData__FlushZ21
	.word gmGameData__FlushZ21, gmGameData__FlushZ31
	.word gmGameData__FlushZ51, gmGameData__FlushZ51
	.word gmGameData__FlushZ91, gmGameData__FlushZ41
	.word gmGameData__FlushZ91, gmGameData__FlushZ11
	.word gmGameData__FlushZ21, gmGameData__FlushZ31
	.word gmGameData__FlushZ41, gmGameData__FlushZ91
	.word gmGameData__FlushZ91, gmGameData__FlushZ91

.public buildAreaTable
buildAreaTable: // 0x0210DA70
	.word gmGameData__BuildZ11, gmGameData__BuildZ12
	.word gmGameData__BuildZ1T, gmGameData__BuildZ1B
	.word gmGameData__BuildZ21, gmGameData__BuildZ22
	.word gmGameData__BuildZ2B, gmGameData__BuildZ31
	.word gmGameData__BuildZ32, gmGameData__BuildZ91
	.word gmGameData__BuildZ3B, gmGameData__BuildZ41
	.word gmGameData__BuildZ42, gmGameData__BuildZ4B
	.word gmGameData__BuildZ51, gmGameData__BuildZ52
	.word gmGameData__BuildZ5B, gmGameData__BuildZ61
	.word gmGameData__BuildZ62, gmGameData__BuildZ91
	.word gmGameData__BuildZ6B, gmGameData__BuildZ71
	.word gmGameData__BuildZ72, gmGameData__BuildZ7B
	.word gmGameData__BuildZFB, gmGameData__BuildZ91
	.word gmGameData__BuildZ31, gmGameData__BuildZ91
	.word gmGameData__BuildZ11, gmGameData__BuildZ11
	.word gmGameData__BuildZ31, gmGameData__BuildZ21
	.word gmGameData__BuildZ21, gmGameData__BuildZ31
	.word gmGameData__BuildZ51, gmGameData__BuildZ51
	.word gmGameData__BuildZ91, gmGameData__BuildZ41
	.word gmGameData__BuildZ91, gmGameData__BuildZ11
	.word gmGameData__BuildZ21, gmGameData__BuildZ31
	.word gmGameData__BuildZ41, gmGameData__BuildZ91
	.word gmGameData__BuildZ91, gmGameData__BuildZ91
	
.public releaseAreaTable
releaseAreaTable: // 0x0210DB28
	.word gmGameData__ReleaseZ11, gmGameData__ReleaseZ12
	.word gmGameData__ReleaseZ1T, gmGameData__ReleaseZ1B
	.word gmGameData__ReleaseZ21, gmGameData__ReleaseZ22
	.word gmGameData__ReleaseZ2B, gmGameData__ReleaseZ31
	.word gmGameData__ReleaseZ32, gmGameData__ReleaseZ91
	.word gmGameData__ReleaseZ3B, gmGameData__ReleaseZ41
	.word gmGameData__ReleaseZ42, gmGameData__ReleaseZ4B
	.word gmGameData__ReleaseZ51, gmGameData__ReleaseZ52
	.word gmGameData__ReleaseZ5B, gmGameData__ReleaseZ61
	.word gmGameData__ReleaseZ62, gmGameData__ReleaseZ91
	.word gmGameData__ReleaseZ6B, gmGameData__ReleaseZ71
	.word gmGameData__ReleaseZ72, gmGameData__ReleaseZ7B
	.word gmGameData__ReleaseZFB, gmGameData__ReleaseZ91
	.word gmGameData__ReleaseZ31, gmGameData__ReleaseZ91
	.word gmGameData__ReleaseZ11, gmGameData__ReleaseZ11
	.word gmGameData__ReleaseZ31, gmGameData__ReleaseZ21
	.word gmGameData__ReleaseZ21, gmGameData__ReleaseZ31
	.word gmGameData__ReleaseZ51, gmGameData__ReleaseZ51
	.word gmGameData__ReleaseZ91, gmGameData__ReleaseZ41
	.word gmGameData__ReleaseZ91, gmGameData__ReleaseZ11
	.word gmGameData__ReleaseZ21, gmGameData__ReleaseZ31
	.word gmGameData__ReleaseZ41, gmGameData__ReleaseZ91
	.word gmGameData__ReleaseZ91, gmGameData__ReleaseZ91

.public assetList_Z2B
assetList_Z2B:
        .word aNarcZ2bossActL
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitStageArchive

        .word aNarcZ2bossRawN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitRawArchive

        .word aNarcZ2bossMapN
        .word LoadAlloc_FromTail
        .word 0
        .word PostLoad_InitMapArchive

        .word aNarcZ2bossEveN
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitEveArchive

        .word aBgZ2bossBbg
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitMapFar

        .word aSndZ2bSoundDat
        .word LoadAlloc_Snd
        .word PreLoad_SoundArchiveBoss
        .word PostLoad_InitSoundArchive

        .word aModBoss2BodyLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2ArmLz7
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2DropLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2BallLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2SpikeL
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2ZakoLz
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2Stage0
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2

        .word aModBoss2Stage0_0
        .word LoadAlloc_FromHead
        .word 0
        .word PostLoad_InitBossAssetsZ2
	
.public assetList_Stage
assetList_Stage: // 0x0210DCC0
	.word assetList_Z11, 6
	.word assetList_Z12, 6
	.word assetList_Z1T, 6
	.word assetList_Z1B, 8
	.word assetList_Z21, 6
	.word assetList_Z22, 6
	.word assetList_Z2B, 14
	.word assetList_Z31, 6
	.word assetList_Z32, 6
	.word assetList_Z91, 6
	.word assetList_Z3B, 11
	.word assetList_Z41, 6
	.word assetList_Z42, 6
	.word assetList_Z4B, 9
	.word assetList_Z51, 6
	.word assetList_Z52, 6
	.word assetList_Z5B, 10
	.word assetList_Z61, 6
	.word assetList_Z62, 6
	.word assetList_Z92, 6
	.word assetList_Z6B, 10
	.word assetList_Z71, 6
	.word assetList_Z72, 6
	.word assetList_Z7B, 8
	.word assetList_ZFB, 9
	.word assetList_Z93, 6
	.word assetList_Z94, 6
	.word assetList_Z95, 6
	.word assetList_Z96, 6
	.word assetList_Z97, 6
	.word assetList_Z98, 6
	.word assetList_Z99, 6
	.word assetList_Z910, 6
	.word assetList_Z911, 6
	.word assetList_Z912, 6
	.word assetList_Z913, 6
	.word assetList_Z914, 6
	.word assetList_Z915, 6
	.word assetList_Z916, 6
	.word assetList_VS1, 6
	.word assetList_VS2, 6
	.word assetList_VS3, 6
	.word assetList_VS4, 6
	.word assetList_R1, 6
	.word assetList_R2, 6
	.word assetList_R3, 6

	.data

aBgZ12Bbg: // 0x02117800
	.asciz "/bg/z12.bbg"
	.align 4
	
aBgZ11Bbg: // 0x0211780C
	.asciz "/bg/z11.bbg"
	.align 4
	
aBgZ91Bbg: // 0x02117818
	.asciz "/bg/z91.bbg"
	.align 4
	
aBgZ41Bbg: // 0x02117824
	.asciz "/bg/z41.bbg"
	.align 4
	
aBgZ51Bbg: // 0x02117830
	.asciz "/bg/z51.bbg"
	.align 4
	
aBgZ61Bbg: // 0x0211783C
	.asciz "/bg/z61.bbg"
	.align 4
	
aBgZ21Bbg: // 0x02117848
	.asciz "/bg/z21.bbg"
	.align 4
	
aBgZ71Bbg: // 0x02117854
	.asciz "/bg/z71.bbg"
	.align 4
	
aBgZ31Bbg: // 0x02117860
	.asciz "/bg/z31.bbg"
	.align 4
	
aBgZ5bossBbg: // 0x0211786C
	.asciz "/bg/z5boss.bbg"
	.align 4
	
aBgZ1bossBbg: // 0x0211787C
	.asciz "/bg/z1boss.bbg"
	.align 4

aBgZ4bossBbg: // 0x0211788C
	.asciz "/bg/z4boss.bbg"
	.align 4

aBgZ7bossBbg: // 0x0211789C
	.asciz "/bg/z7boss.bbg"
	.align 4

aBgZ2bossBbg: // 0x021178AC
	.asciz "/bg/z2boss.bbg"
	.align 4

aBgZ6bossBbg: // 0x021178BC
	.asciz "/bg/z6boss.bbg"
	.align 4

aBgZ8bossBbg: // 0x021178CC
	.asciz "/bg/z8boss.bbg"
	.align 4

aBgZ3bossBbg: // 0x021178DC
	.asciz "/bg/z3boss.bbg"
	.align 4

aNarcZm1MapNarc: // 0x021178EC
	.asciz "/narc/zm1_map.narc"
	.align 4

aNarcZ51MapNarc: // 0x02117900
	.asciz "/narc/z51_map.narc"
	.align 4

aNarcZ21MapNarc: // 0x02117914
	.asciz "/narc/z21_map.narc"
	.align 4

aNarcZv2EveNarc: // 0x02117928
	.asciz "/narc/zv2_eve.narc"
	.align 4

aNarcZr1MapNarc: // 0x0211793C
	.asciz "/narc/zr1_map.narc"
	.align 4

aNarcZ31EveNarc: // 0x02117950
	.asciz "/narc/z31_eve.narc"
	.align 4

aNarcZ22RawNarc: // 0x02117964
	.asciz "/narc/z22_raw.narc"
	.align 4

aNarcZ11EveNarc: // 0x02117978
	.asciz "/narc/z11_eve.narc"
	.align 4

aNarcZr1EveNarc: // 0x0211798C
	.asciz "/narc/zr1_eve.narc"
	.align 4

aNarcZv1EveNarc: // 0x021179A0
	.asciz "/narc/zv1_eve.narc"
	.align 4

aNarcZv2MapNarc: // 0x021179B4
	.asciz "/narc/zv2_map.narc"
	.align 4

aNarcZ22MapNarc: // 0x021179C8
	.asciz "/narc/z22_map.narc"
	.align 4

aNarcZ22EveNarc: // 0x021179DC
	.asciz "/narc/z22_eve.narc"
	.align 4

aNarcZv4MapNarc: // 0x021179F0
	.asciz "/narc/zv4_map.narc"
	.align 4

aNarcZm4EveNarc: // 0x02117A04
	.asciz "/narc/zm4_eve.narc"
	.align 4

aNarcZm9EveNarc: // 0x02117A18
	.asciz "/narc/zm9_eve.narc"
	.align 4

aNarcZ91MapNarc: // 0x02117A2C
	.asciz "/narc/z91_map.narc"
	.align 4

aNarcZv3EveNarc: // 0x02117A40
	.asciz "/narc/zv3_eve.narc"
	.align 4

aNarcZ42MapNarc: // 0x02117A54
	.asciz "/narc/z42_map.narc"
	.align 4

aNarcZ32RawNarc: // 0x02117A68
	.asciz "/narc/z32_raw.narc"
	.align 4

aNarcZm5MapNarc: // 0x02117A7C
	.asciz "/narc/zm5_map.narc"
	.align 4

aNarcZ72EveNarc: // 0x02117A90
	.asciz "/narc/z72_eve.narc"
	.align 4

aNarcZ71EveNarc: // 0x02117AA4
	.asciz "/narc/z71_eve.narc"
	.align 4

aNarcZr3EveNarc: // 0x02117AB8
	.asciz "/narc/zr3_eve.narc"
	.align 4

aNarcZm4MapNarc: // 0x02117ACC
	.asciz "/narc/zm4_map.narc"
	.align 4

aNarcZ32MapNarc: // 0x02117AE0
	.asciz "/narc/z32_map.narc"
	.align 4

aNarcZ41MapNarc: // 0x02117AF4
	.asciz "/narc/z41_map.narc"
	.align 4

aNarcZm6EveNarc: // 0x02117B08
	.asciz "/narc/zm6_eve.narc"
	.align 4

aNarcZm2EveNarc: // 0x02117B1C
	.asciz "/narc/zm2_eve.narc"
	.align 4

aNarcZv1MapNarc: // 0x02117B30
	.asciz "/narc/zv1_map.narc"
	.align 4

aNarcZm7EveNarc: // 0x02117B44
	.asciz "/narc/zm7_eve.narc"
	.align 4

aNarcZ1tMapNarc: // 0x02117B58
	.asciz "/narc/z1t_map.narc"
	.align 4

aNarcZ91EveNarc: // 0x02117B6C
	.asciz "/narc/z91_eve.narc"
	.align 4

aNarcZ41RawNarc: // 0x02117B80
	.asciz "/narc/z41_raw.narc"
	.align 4

aNarcZ32EveNarc: // 0x02117B94
	.asciz "/narc/z32_eve.narc"
	.align 4

aNarcZ94MapNarc: // 0x02117BA8
	.asciz "/narc/z94_map.narc"
	.align 4

aNarcZ61RawNarc: // 0x02117BBC
	.asciz "/narc/z61_raw.narc"
	.align 4

aNarcZm1EveNarc: // 0x02117BD0
	.asciz "/narc/zm1_eve.narc"
	.align 4

aNarcZ51EveNarc: // 0x02117BE4
	.asciz "/narc/z51_eve.narc"
	.align 4

aNarcZ71RawNarc: // 0x02117BF8
	.asciz "/narc/z71_raw.narc"
	.align 4

aNarcZ62EveNarc: // 0x02117C0C
	.asciz "/narc/z62_eve.narc"
	.align 4

aNarcZ71MapNarc: // 0x02117C20
	.asciz "/narc/z71_map.narc"
	.align 4

aNarcZ12EveNarc: // 0x02117C34
	.asciz "/narc/z12_eve.narc"
	.align 4

aNarcZm5EveNarc: // 0x02117C48
	.asciz "/narc/zm5_eve.narc"
	.align 4

aNarcZ52MapNarc: // 0x02117C5C
	.asciz "/narc/z52_map.narc"
	.align 4

aNarcZ42RawNarc: // 0x02117C70
	.asciz "/narc/z42_raw.narc"
	.align 4

aNarcZ11MapNarc: // 0x02117C84
	.asciz "/narc/z11_map.narc"
	.align 4

aNarcZ11RawNarc: // 0x02117C98
	.asciz "/narc/z11_raw.narc"
	.align 4

aNarcZ12RawNarc: // 0x02117CAC
	.asciz "/narc/z12_raw.narc"
	.align 4

aNarcZ52EveNarc: // 0x02117CC0
	.asciz "/narc/z52_eve.narc"
	.align 4

aNarcZ91RawNarc: // 0x02117CD4
	.asciz "/narc/z91_raw.narc"
	.align 4

aNarcZ52RawNarc: // 0x02117CE8
	.asciz "/narc/z52_raw.narc"
	.align 4

aNarcZm7MapNarc: // 0x02117CFC
	.asciz "/narc/zm7_map.narc"
	.align 4

aNarcZ33EveNarc: // 0x02117D10
	.asciz "/narc/z33_eve.narc"
	.align 4

aNarcZ1tEveNarc: // 0x02117D24
	.asciz "/narc/z1t_eve.narc"
	.align 4

aNarcZ33MapNarc: // 0x02117D38
	.asciz "/narc/z33_map.narc"
	.align 4

aNarcZv3MapNarc: // 0x02117D4C
	.asciz "/narc/zv3_map.narc"
	.align 4

aNarcZ72MapNarc: // 0x02117D60
	.asciz "/narc/z72_map.narc"
	.align 4

aNarcZm2MapNarc: // 0x02117D74
	.asciz "/narc/zm2_map.narc"
	.align 4

aNarcZm6MapNarc: // 0x02117D88
	.asciz "/narc/zm6_map.narc"
	.align 4

aNarcZm9MapNarc: // 0x02117D9C
	.asciz "/narc/zm9_map.narc"
	.align 4

aNarcZm8MapNarc: // 0x02117DB0
	.asciz "/narc/zm8_map.narc"
	.align 4

aNarcZv4EveNarc: // 0x02117DC4
	.asciz "/narc/zv4_eve.narc"
	.align 4

aNarcZ42EveNarc: // 0x02117DD8
	.asciz "/narc/z42_eve.narc"
	.align 4

aNarcZm8EveNarc: // 0x02117DEC
	.asciz "/narc/zm8_eve.narc"
	.align 4

aNarcZ92MapNarc: // 0x02117E00
	.asciz "/narc/z92_map.narc"
	.align 4

aNarcZ41EveNarc: // 0x02117E14
	.asciz "/narc/z41_eve.narc"
	.align 4

aNarcZ93MapNarc: // 0x02117E28
	.asciz "/narc/z93_map.narc"
	.align 4

aNarcZ12MapNarc: // 0x02117E3C
	.asciz "/narc/z12_map.narc"
	.align 4

aNarcZ72RawNarc: // 0x02117E50
	.asciz "/narc/z72_raw.narc"
	.align 4

aNarcZ92EveNarc: // 0x02117E64
	.asciz "/narc/z92_eve.narc"
	.align 4

aNarcZ61MapNarc: // 0x02117E78
	.asciz "/narc/z61_map.narc"
	.align 4

aNarcZr3MapNarc: // 0x02117E8C
	.asciz "/narc/zr3_map.narc"
	.align 4

aNarcZ51RawNarc: // 0x02117EA0
	.asciz "/narc/z51_raw.narc"
	.align 4

aNarcZ61EveNarc: // 0x02117EB4
	.asciz "/narc/z61_eve.narc"
	.align 4

aNarcZm3EveNarc: // 0x02117EC8
	.asciz "/narc/zm3_eve.narc"
	.align 4

aNarcZm3MapNarc: // 0x02117EDC
	.asciz "/narc/zm3_map.narc"
	.align 4

aNarcZ31MapNarc: // 0x02117EF0
	.asciz "/narc/z31_map.narc"
	.align 4

aNarcZ94EveNarc: // 0x02117F04
	.asciz "/narc/z94_eve.narc"
	.align 4

aNarcZr2EveNarc: // 0x02117F18
	.asciz "/narc/zr2_eve.narc"
	.align 4

aNarcZr2MapNarc: // 0x02117F2C
	.asciz "/narc/zr2_map.narc"
	.align 4

aNarcZ31RawNarc: // 0x02117F40
	.asciz "/narc/z31_raw.narc"
	.align 4

aNarcZ62RawNarc: // 0x02117F54
	.asciz "/narc/z62_raw.narc"
	.align 4

aNarcZ93EveNarc: // 0x02117F68
	.asciz "/narc/z93_eve.narc"
	.align 4

aNarcZ62MapNarc: // 0x02117F7C
	.asciz "/narc/z62_map.narc"
	.align 4

aNarcZ21EveNarc: // 0x02117F90
	.asciz "/narc/z21_eve.narc"
	.align 4

aNarcZ21RawNarc: // 0x02117FA4
	.asciz "/narc/z21_raw.narc"
	.align 4

aNarcZm10MapNar: // 0x02117FB8
	.asciz "/narc/zm10_map.narc"
	.align 4

aNarcZm10EveNar: // 0x02117FCC
	.asciz "/narc/zm10_eve.narc"
	.align 4
        
aNarcZm11MapNar: // 0x02117FE0
	.asciz "/narc/zm11_map.narc"
	.align 4
        
aNarcZm11EveNar: // 0x02117FF4
	.asciz "/narc/zm11_eve.narc"
	.align 4
        
aNarcZ6bossEveN: // 0x02118008
	.asciz "/narc/z6boss_eve.narc"
	.align 4

aNarcZ1bossEveN: // 0x02118020
	.asciz "/narc/z1boss_eve.narc"
	.align 4

aNarcZ2bossRawN: // 0x02118038
	.asciz "/narc/z2boss_raw.narc"
	.align 4

aNarcZ2bossMapN: // 0x02118050
	.asciz "/narc/z2boss_map.narc"
	.align 4

aNarcZ2bossEveN: // 0x02118068
	.asciz "/narc/z2boss_eve.narc"
	.align 4

aNarcZ7bossRawN: // 0x02118080
	.asciz "/narc/z7boss_raw.narc"
	.align 4

aNarcZ7bossMapN: // 0x02118098
	.asciz "/narc/z7boss_map.narc"
	.align 4

aNarcZ7bossEveN: // 0x021180B0
	.asciz "/narc/z7boss_eve.narc"
	.align 4

aNarcZ1bossMapN: // 0x021180C8
	.asciz "/narc/z1boss_map.narc"
	.align 4

aNarcZ3bossMapN: // 0x021180E0
	.asciz "/narc/z3boss_map.narc"
	.align 4

aNarcZ3bossEveN: // 0x021180F8
	.asciz "/narc/z3boss_eve.narc"
	.align 4

aNarcZ3bossRawN: // 0x02118110
	.asciz "/narc/z3boss_raw.narc"
	.align 4

aNarcZ4bossRawN: // 0x02118128
	.asciz "/narc/z4boss_raw.narc"
	.align 4

aNarcZ6bossMapN: // 0x02118140
	.asciz "/narc/z6boss_map.narc"
	.align 4

aNarcZ8bossRawN: // 0x02118158
	.asciz "/narc/z8boss_raw.narc"
	.align 4

aNarcZ8bossMapN: // 0x02118170
	.asciz "/narc/z8boss_map.narc"
	.align 4

aNarcZ8bossEveN: // 0x02118188
	.asciz "/narc/z8boss_eve.narc"
	.align 4

aNarcZ4bossMapN: // 0x021181A0
	.asciz "/narc/z4boss_map.narc"
	.align 4

aNarcZ6bossRawN: // 0x021181B8
	.asciz "/narc/z6boss_raw.narc"
	.align 4

aNarcZ4bossEveN: // 0x021181D0
	.asciz "/narc/z4boss_eve.narc"
	.align 4

aNarcZ5bossRawN: // 0x021181E8
	.asciz "/narc/z5boss_raw.narc"
	.align 4

aNarcZ5bossMapN: // 0x02118200
	.asciz "/narc/z5boss_map.narc"
	.align 4

aNarcZ5bossEveN: // 0x02118218
	.asciz "/narc/z5boss_eve.narc"
	.align 4

aNarcZ1bossRawN: // 0x02118230
	.asciz "/narc/z1boss_raw.narc"
	.align 4

aNarcPlayerLz7N: // 0x02118248
	.asciz "/narc/player_lz7.narc"
	.align 4

aNarcZ11ActLz7N: // 0x02118260
	.asciz "/narc/z11_act_lz7.narc"
	.align 4

aNarcZ21ActLz7N: // 0x02118278
	.asciz "/narc/z21_act_lz7.narc"
	.align 4

aNarcZ71ActLz7N: // 0x02118290
	.asciz "/narc/z71_act_lz7.narc"
	.align 4

aNarcZ31ActLz7N: // 0x021182A8
	.asciz "/narc/z31_act_lz7.narc"
	.align 4

aNarcZ41ActLz7N: // 0x021182C0
	.asciz "/narc/z41_act_lz7.narc"
	.align 4

aNarcZ1tActLz7N: // 0x021182D8
	.asciz "/narc/z1t_act_lz7.narc"
	.align 4

aNarcZ51ActLz7N: // 0x021182F0
	.asciz "/narc/z51_act_lz7.narc"
	.align 4

aNarcZ52ActLz7N: // 0x02118308
	.asciz "/narc/z52_act_lz7.narc"
	.align 4

aNarcZ91ActLz7N: // 0x02118320
	.asciz "/narc/z91_act_lz7.narc"
	.align 4

aNarcZ61ActLz7N: // 0x02118338
	.asciz "/narc/z61_act_lz7.narc"
	.align 4

aNarcActComLz7N: // 0x02118350
	.asciz "/narc/act_com_lz7.narc"
	.align 4

aSndZ11SoundDat: // 0x02118368
	.asciz "/snd/z11/sound_data.sdat"
	.align 4

aSndZ62SoundDat: // 0x02118384
	.asciz "/snd/z62/sound_data.sdat"
	.align 4

aSndZ12SoundDat: // 0x021183A0
	.asciz "/snd/z12/sound_data.sdat"
	.align 4

aSndZ21SoundDat: // 0x021183BC
	.asciz "/snd/z21/sound_data.sdat"
	.align 4

aModBoss6SkyLz7: // 0x021183D8
	.asciz "/mod/boss6_sky_lz7.nsbmd"
	.align 4

aSndZ22SoundDat: // 0x021183F4
	.asciz "/snd/z22/sound_data.sdat"
	.align 4

aSndZ2bSoundDat: // 0x02118410
	.asciz "/snd/z2b/sound_data.sdat"
	.align 4

aModBoss2ArmLz7: // 0x0211842C
	.asciz "/mod/boss2_arm_lz7.nsbmd"
	.align 4

aSndZ6bSoundDat: // 0x02118448
	.asciz "/snd/z6b/sound_data.sdat"
	.align 4

aSndZ72SoundDat: // 0x02118464
	.asciz "/snd/z72/sound_data.sdat"
	.align 4

aSndZ1bSoundDat: // 0x02118480
	.asciz "/snd/z1b/sound_data.sdat"
	.align 4

aSndZ31SoundDat: // 0x0211849C
	.asciz "/snd/z31/sound_data.sdat"
	.align 4

aSndZ32SoundDat: // 0x021184B8
	.asciz "/snd/z32/sound_data.sdat"
	.align 4

aSndZ7bSoundDat: // 0x021184D4
	.asciz "/snd/z7b/sound_data.sdat"
	.align 4

aSndZ3bSoundDat: // 0x021184F0
	.asciz "/snd/z3b/sound_data.sdat"
	.align 4

aSndZ71SoundDat: // 0x0211850C
	.asciz "/snd/z71/sound_data.sdat"
	.align 4

aSndZ41SoundDat: // 0x02118528
	.asciz "/snd/z41/sound_data.sdat"
	.align 4

aSndZ42SoundDat: // 0x02118544
	.asciz "/snd/z42/sound_data.sdat"
	.align 4

aSndZfbSoundDat: // 0x02118560
	.asciz "/snd/zfb/sound_data.sdat"
	.align 4

aSndZ4bSoundDat: // 0x0211857C
	.asciz "/snd/z4b/sound_data.sdat"
	.align 4

aSndZ1tSoundDat: // 0x02118598
	.asciz "/snd/z1t/sound_data.sdat"
	.align 4

aSndZ51SoundDat: // 0x021185B4
	.asciz "/snd/z51/sound_data.sdat"
	.align 4

aSndZ52SoundDat: // 0x021185D0
	.asciz "/snd/z52/sound_data.sdat"
	.align 4

aSndZ5bSoundDat: // 0x021185EC
	.asciz "/snd/z5b/sound_data.sdat"
	.align 4

aSndZ91SoundDat: // 0x02118608
	.asciz "/snd/z91/sound_data.sdat"
	.align 4

aSndZ61SoundDat: // 0x02118624
	.asciz "/snd/z61/sound_data.sdat"
	.align 4

aNarcActComBLz7: // 0x02118640
	.asciz "/narc/act_com_b_lz7.narc"
	.align 4

aNarcZ6bossActL: // 0x0211865C
	.asciz "/narc/z6boss_act_lz7.narc"
	.align 4

aModBoss1BodyLz: // 0x02118678
	.asciz "/mod/boss1_body_lz7.nsbmd"
	.align 4

aModBoss6BodyLz: // 0x02118694
	.asciz "/mod/boss6_body_lz7.nsbmd"
	.align 4

aModBoss6ZakoLz: // 0x021186B0
	.asciz "/mod/boss6_zako_lz7.nsbmd"
	.align 4

aNarcZ2bossActL: // 0x021186CC
	.asciz "/narc/z2boss_act_lz7.narc"
	.align 4
	
aModBoss2BodyLz: // 0x021186E8
	.asciz "/mod/boss2_body_lz7.nsbmd"
	.align 4
	
aModBoss2DropLz: // 0x02118704
	.asciz "/mod/boss2_drop_lz7.nsbmd"
	.align 4
	
aModBoss2BallLz: // 0x02118720
	.asciz "/mod/boss2_ball_lz7.nsbmd"
	.align 4
	
aModBoss2ZakoLz: // 0x0211873C
	.asciz "/mod/boss2_zako_lz7.nsbmd"
	.align 4
	
aNarcZ7bossActL: // 0x02118758
	.asciz "/narc/z7boss_act_lz7.narc"
	.align 4
	
aNarcZ3bossActL: // 0x02118774
	.asciz "/narc/z3boss_act_lz7.narc"
	.align 4
	
aModBoss3BodyLz: // 0x02118790
	.asciz "/mod/boss3_body_lz7.nsbmd"
	.align 4
	
aModBoss7BodyLz: // 0x021187AC
	.asciz "/mod/boss7_body_lz7.nsbmd"
	.align 4
	
aNarcZ8bossActL: // 0x021187C8
	.asciz "/narc/z8boss_act_lz7.narc"
	.align 4
	
aNarcZ1bossActL: // 0x021187E4
	.asciz "/narc/z1boss_act_lz7.narc"
	.align 4
	
aModBossfBodyLz: // 0x02118800
	.asciz "/mod/bossF_body_lz7.nsbmd"
	.align 4
	
aNarcZ4bossActL: // 0x0211881C
	.asciz "/narc/z4boss_act_lz7.narc"
	.align 4
	
aModBoss4BodyLz: // 0x02118838
	.asciz "/mod/boss4_body_lz7.nsbmd"
	.align 4
	
aModBoss4CoreLz: // 0x02118854
	.asciz "/mod/boss4_core_lz7.nsbmd"
	.align 4
	
aNarcZ5bossActL: // 0x02118870
	.asciz "/narc/z5boss_act_lz7.narc"
	.align 4
	
aModBoss5BodyLz: // 0x0211888C
	.asciz "/mod/boss5_body_lz7.nsbmd"
	.align 4
	
aModBoss5CoreLz: // 0x021188A8
	.asciz "/mod/boss5_core_lz7.nsbmd"
	.align 4
	
aModBoss1StageL: // 0x021188C4
	.asciz "/mod/boss1_stage_lz7.nsbmd"
	.align 4
	
aModBoss6StageL: // 0x021188E0
	.asciz "/mod/boss6_stage_lz7.nsbmd"
	.align 4
	
aModBoss2SpikeL: // 0x021188FC
	.asciz "/mod/boss2_spike_lz7.nsbmd"
	.align 4
	
aModBoss7StageL: // 0x02118918
	.asciz "/mod/boss7_stage_lz7.nsbmd"
	.align 4
	
aModBossfArmLLz: // 0x02118934
	.asciz "/mod/bossF_arm_l_lz7.nsbmd"
	.align 4
	
aModBossfArmRLz: // 0x02118950
	.asciz "/mod/bossF_arm_r_lz7.nsbmd"
	.align 4
	
aModBoss4StageL: // 0x0211896C
	.asciz "/mod/boss4_stage_lz7.nsbmd"
	.align 4
	
aModBoss5StageL: // 0x02118988
	.asciz "/mod/boss5_stage_lz7.nsbmd"
	.align 4
	
aModBoss5MapALz: // 0x021189A4
	.asciz "/mod/boss5_map_a_lz7.nsbmd"
	.align 4
	
aModBoss2Stage0: // 0x021189C0
	.asciz "/mod/boss2_stage_00_lz7.nsbmd"
	.align 4
	
aModBoss2Stage0_0: // 0x021189E0
	.asciz "/mod/boss2_stage_01_lz7.nsbmd"
	.align 4
	
aModBoss3Stage0: // 0x02118A00
	.asciz "/mod/boss3_stage_00_lz7.nsbmd"
	.align 4
	
aModBoss3Stage0_0: // 0x02118A20
	.asciz "/mod/boss3_stage_01_lz7.nsbmd"
	.align 4
	
.public aModBoss3Stage0_1
aModBoss3Stage0_1: // 0x02118A40
	.asciz "/mod/boss3_stage_02_lz7.nsbmd"
	.align 4
	
.public aModBoss3Stage0_2
aModBoss3Stage0_2: // 0x02118A60
	.asciz "/mod/boss3_stage_03_lz7.nsbmd"
	.align 4